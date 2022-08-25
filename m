Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6CE5A0B19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiHYIIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiHYIIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:08:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CC8A50CB;
        Thu, 25 Aug 2022 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jnkBb2miH3HIXnoCKdfSzn3ZLM+gMDwr3quqYEHvb5o=;
        t=1661414923; x=1662624523; b=I5BLy7PCAC5CDtkFAOLXLxv/wZ8FI/Q/Gt20Xd2sHnXW80t
        +dvYUqmlfRLz4y8zd0agWZwEh0ce/BxihJXQhEMgsBg4ymB6jksBLlulOwBUbBAu/OJ9r17YyXFew
        glQChTg3xeUPJSvGlS1NdPWHNgINBehZ4daJmkB75Fo81YaOVaZpMtfwwOPoQo7xnRyWB+i2XlNY4
        zpfgDXmE0O7CIR8H4Zpuro0jIMoa9GSXaAttdqY7nWq80KkWZJAcpz+un2+3vyKGEywNvMsdMKUB3
        y3neyljSv/PbX2LH08Cz3pW/qmPHK/C/sVnDCoWXoKK9Ya2aEd4F5wac2GbimLfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oR7ur-00GymP-1V;
        Thu, 25 Aug 2022 10:08:41 +0200
Message-ID: <f97efe8ff5f466ce938f38dc26cb76c7abcc5a71.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ieee80211: Fix for fragmented action frames
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 25 Aug 2022 10:08:40 +0200
In-Reply-To: <20220810224804.2137240-1-gilad.itzkovitch@morsemicro.com>
References: <20220810224804.2137240-1-gilad.itzkovitch@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-11 at 10:48 +1200, Gilad Itzkovitch wrote:
> The robust management frame check ensures a station exists for
> the frame before proceeding, but there are some action frame
> categories which don't require an existing station, and so the
> _ieee80211_is_robust_mgmt_frame function peeks into the
> action frame's payload to identify the category and filter them out.
>=20
> In some scenarios, e.g. DPP at S1G data rates, action frames
> can get fragmented. This commit adds an extra check to ensure
> we don't peek into the payload of fragmented frames beyond the
> first fragment.
>=20
> Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
> ---
>  include/linux/ieee80211.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> index 55e6f4ad0ca6..5da9608fdce3 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -4124,6 +4124,7 @@ static inline bool _ieee80211_is_robust_mgmt_frame(=
struct ieee80211_hdr *hdr)
> =20
>  	if (ieee80211_is_action(hdr->frame_control)) {
>  		u8 *category;
> +		u16 sc;
> =20
>  		/*
>  		 * Action frames, excluding Public Action frames, are Robust
> @@ -4134,6 +4135,17 @@ static inline bool _ieee80211_is_robust_mgmt_frame=
(struct ieee80211_hdr *hdr)
>  		 */
>  		if (ieee80211_has_protected(hdr->frame_control))
>  			return true;
> +
> +		/*
> +		 * Some action frames do not have a STA associated with them,
> +		 * so we rule them out from the robust management frame check.
> +		 * The category is within the payload, so we only proceed if
> +		 * we're checking the first fragment.
> +		 */
> +		sc =3D le16_to_cpu(hdr->seq_ctrl);
> +		if (sc & IEEE80211_SCTL_FRAG)
> +			return false;
>=20


This doesn't make much sense to me - why would it be allowed or
necessary to call this function on a frame that wasn't yet defragmented?

johannes
