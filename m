Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA3759C512
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiHVRfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbiHVRfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:35:11 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D0540BC6;
        Mon, 22 Aug 2022 10:35:07 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 535298E25E2;
        Mon, 22 Aug 2022 17:35:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a277.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 713E78E0C8E;
        Mon, 22 Aug 2022 17:35:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661189702; a=rsa-sha256;
        cv=none;
        b=QCAl5xH3V3JdRF4LDIGoG/mm3ITqYi00GwJlCI/NfKiZThuyeQXhjjrcOFt0iVo0h2L2q7
        VGvU/z4b6QHSdwkySQlQPjkdvZvRqKN1nJBQu0vNysq5wiGO6xdY44H/rNrtuuW0TUugHz
        i6f1sfC/myz4jpm/05unIwjeBRHpt+liFz/vQRfq/E72xbmpo7UZNkkA6X55naogjNYeZV
        1+/+P6X4D26Lb84/V1z14ZpC6Lp/SV73twFWDhe29KUm+tpyLyQRiOVgApRstUqG6/ZoOB
        ayTqzrHuvjFnhINVQSP6T90/JnRieS+zs0QLTIovvrewtOaulrKyEFtb8hXl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661189702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=LZt4EKW2Klj6HswzcAhuLRqO+KGezqgdN643l6Y4ioE=;
        b=z0IZxbGdIOluzPrYLkJroyVo8BpCEz0yNM2h+IdIFPvrm6PiqXxvXx+bJKsdHxWJAWjSoI
        RCobVIsaenMkSuZhjTJLc+cmpkA/XxuKCzHCx6hBGkq1fL1nX3BEG+s9eNWrxr5Hfbdsz5
        sb5x/W0jgkR2SB2T8vusMJc5yyfmKZaYravWLh46vYfGqiWmIp0pumJ6PIBm/+N6MzkDUn
        bPNIMBejliodQMELpt9njDgfBRcdNoI3OsJQTZ03+nV8ASv9FmvnicWeWIbRrYoBIwPgRy
        ZMFeWqBudF1HwuDOZ6cTlRz+pfpfPXzcZQvvID69YCkMbpC/NEmmZWSwzUsY2w==
ARC-Authentication-Results: i=1;
        rspamd-769cfffc99-7h8h8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Battle: 64f1b0cf2bad831f_1661189702782_2177706590
X-MC-Loop-Signature: 1661189702782:1915979762
X-MC-Ingress-Time: 1661189702782
Received: from pdx1-sub0-mail-a277.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.45.14 (trex/6.7.1);
        Mon, 22 Aug 2022 17:35:02 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a277.dreamhost.com (Postfix) with ESMTPSA id 4MBKHn5vY1z2m;
        Mon, 22 Aug 2022 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661189702;
        bh=LZt4EKW2Klj6HswzcAhuLRqO+KGezqgdN643l6Y4ioE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=l+fH5hxu/zaQqAJKbNMZ9Nf0CpAuK+rlYGBnom8QOROjy/XPzxtZlbeCVKhDLgNnV
         sQLXQ2uPR+JtbbGQsQwn8GrQ37dGN+3omNW3QUBED8gzmMptjwUmr2PMTgjDqta9OL
         1mbgdNU5xTc6QQnzDmW3EbVfruZEOjar1gL9KlJSbJm/9tgOaM6bo7rCqqMUN/gu3Y
         DLlILDsEx5po5LGy/uyxI/gK0SMz7AMnPC1SqCvcK18dYmcdu+C2OYkr03vJPmk5WJ
         sjhapDwHu92nTf3EsfreAUqm3wkySCtZRCyuBVcKWNYVZCqndmg4OANuWFjlw97QiV
         nQpTCzIvtlYUA==
Date:   Mon, 22 Aug 2022 10:17:03 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "widawsk@kernel.org" <widawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: Replace HDM decoder granularity magic numbers
Message-ID: <20220822171703.sfizbmn6retpxggi@offworld>
References: <CGME20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0@uscas1p1.samsung.com>
 <20220822170510.125082-1-a.manzanares@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822170510.125082-1-a.manzanares@samsung.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Adam Manzanares wrote:

>When reviewing the CFMWS parsing code that deals with the HDM decoders,
>I noticed a couple of magic numbers. This commit replaces these magic numbers
>with constants defined by the CXL 2.0 specification.

Please use 3.0 spec :)

Actually the whole drivers/cxl/* could use updating the comments for 3.0.

>Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
>---
> drivers/cxl/cxl.h | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>index f680450f0b16..ba3a66b5b9cd 100644
>--- a/drivers/cxl/cxl.h
>+++ b/drivers/cxl/cxl.h
>@@ -61,6 +61,10 @@
> #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
>
>+/* HDM decoder control register constants CXL 2.0 8.2.5.12.7 */

This now becomes 8.2.4.19.7.

>+#define CXL_DECODER_MIN_GRANULARITY 256
>+#define CXL_DECODER_MAX_GRANULARITY_ORDER 6

Considering there is a single user, I don't think we need to add
the CXL_DECODER_MAX_GRANULARITY_ORDER. And if a new one is added
it would be better to keep symmetry (bytes) and just do
CXL_DECODER_MAX_GRANULARITY, but that's probably the reason why
it doesn't exist in the first place.

>+
> static inline int cxl_hdm_decoder_count(u32 cap_hdr)
> {
>	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
>@@ -71,9 +75,9 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
> /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> static inline int cxl_to_granularity(u16 ig, unsigned int *val)
> {
>-	if (ig > 6)
>+	if (ig > CXL_DECODER_MAX_GRANULARITY_ORDER)
>		return -EINVAL;
>-	*val = 256 << ig;
>+	*val = CXL_DECODER_MIN_GRANULARITY << ig;
>	return 0;
> }
>
>@@ -96,7 +100,7 @@ static inline int cxl_to_ways(u8 eniw, unsigned int *val)
>
> static inline int granularity_to_cxl(int g, u16 *ig)
> {
>-	if (g > SZ_16K || g < 256 || !is_power_of_2(g))
>+	if (g > SZ_16K || g < CXL_DECODER_MIN_GRANULARITY || !is_power_of_2(g))

Looks good.

Thanks,
Davidlohr
