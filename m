Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C41520A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiEJAuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiEJAuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:50:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAA72380CC
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 17:46:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF1761F9EF;
        Tue, 10 May 2022 00:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652143560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtMQXVZDrYDub2elu5mYBR/xnlKkD34z85QlnnWHBJE=;
        b=FXY11OxPVLDYqHQzuMY59q4TCVfC7yzyWSH1yeNLJFpRxpSa8dhwob1xPdf1uOWH3onGI9
        DeS3f4mzjbSdaPYz+mATUc+Pe/8LmX/Q13uZdWEzqiH9lT+wf06bnhDe5fbfB82s7fL1do
        SI7IidNC6s9xQnuhks07IrMpag1bO6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652143560;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtMQXVZDrYDub2elu5mYBR/xnlKkD34z85QlnnWHBJE=;
        b=+cXAQWYZjnP/LmKKet27Ult+XaSpd+yjQVIMlwlnGxRrorlBEeLqSE7b9BFAaOw0BqrAkd
        v2sTeS/J5aI93BBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3429F13A76;
        Tue, 10 May 2022 00:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8AvuN8S1eWJvagAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 10 May 2022 00:45:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Miaohe Lin" <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, apopple@nvidia.com, david@redhat.com,
        surenb@google.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linmiaohe@huawei.com
Subject: Re: [PATCH 11/15] mm/swap: add helper swap_offset_available()
In-reply-to: <20220509131416.17553-12-linmiaohe@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>,
 <20220509131416.17553-12-linmiaohe@huawei.com>
Date:   Tue, 10 May 2022 10:45:54 +1000
Message-id: <165214355418.14782.13896859043718755300@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 May 2022, Miaohe Lin wrote:
> Add helper swap_offset_available() to remove some duplicated codes.
> Minor readability improvement.

I don't think that putting the spin_lock() inside the inline helper is
good for readability.
If the function was called
   swap_offset_available_and_locked()

it might be ok.  Otherwise I would rather the spin_lock() was called
when the function returned true.

Thanks,
NeilBrown

>=20
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/swapfile.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>=20
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c90298a0561a..d5d3e2d03d28 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -776,6 +776,21 @@ static void set_cluster_next(struct swap_info_struct *=
si, unsigned long next)
>  	this_cpu_write(*si->cluster_next_cpu, next);
>  }
> =20
> +static inline bool swap_offset_available(struct swap_info_struct *si, unsi=
gned long offset)
> +{
> +	if (data_race(!si->swap_map[offset])) {
> +		spin_lock(&si->lock);
> +		return true;
> +	}
> +
> +	if (vm_swap_full() && READ_ONCE(si->swap_map[offset]) =3D=3D SWAP_HAS_CAC=
HE) {
> +		spin_lock(&si->lock);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int scan_swap_map_slots(struct swap_info_struct *si,
>  			       unsigned char usage, int nr,
>  			       swp_entry_t slots[])
> @@ -953,15 +968,8 @@ static int scan_swap_map_slots(struct swap_info_struct=
 *si,
>  scan:
>  	spin_unlock(&si->lock);
>  	while (++offset <=3D READ_ONCE(si->highest_bit)) {
> -		if (data_race(!si->swap_map[offset])) {
> -			spin_lock(&si->lock);
> +		if (swap_offset_available(si, offset))
>  			goto checks;
> -		}
> -		if (vm_swap_full() &&
> -		    READ_ONCE(si->swap_map[offset]) =3D=3D SWAP_HAS_CACHE) {
> -			spin_lock(&si->lock);
> -			goto checks;
> -		}
>  		if (unlikely(--latency_ration < 0)) {
>  			cond_resched();
>  			latency_ration =3D LATENCY_LIMIT;
> @@ -970,15 +978,8 @@ static int scan_swap_map_slots(struct swap_info_struct=
 *si,
>  	}
>  	offset =3D si->lowest_bit;
>  	while (offset < scan_base) {
> -		if (data_race(!si->swap_map[offset])) {
> -			spin_lock(&si->lock);
> +		if (swap_offset_available(si, offset))
>  			goto checks;
> -		}
> -		if (vm_swap_full() &&
> -		    READ_ONCE(si->swap_map[offset]) =3D=3D SWAP_HAS_CACHE) {
> -			spin_lock(&si->lock);
> -			goto checks;
> -		}
>  		if (unlikely(--latency_ration < 0)) {
>  			cond_resched();
>  			latency_ration =3D LATENCY_LIMIT;
> --=20
> 2.23.0
>=20
>=20
