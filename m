Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0061A520A21
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiEJAcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiEJAcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:32:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B8931344
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 17:28:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 722561F9DC;
        Tue, 10 May 2022 00:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652142491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PiZ39t1FcyuFoYGrkGdy/soYmQRv3Xc5CdmMi56dLEA=;
        b=wowhvFsqZJFp5HqM0TC60InGTcohlMeI5YvtyE1HXsF4qemd8wDlatJaU77PTafhubwKdS
        t4MtpPICJCGp+zd0AexsxqaAWoEmNkExUBqSiN6uO18NvipPyljG29WIYeuyI4tT7Qpq4S
        0+8okeBoQq2avUqRu7zKjNgo2f33ThM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652142491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PiZ39t1FcyuFoYGrkGdy/soYmQRv3Xc5CdmMi56dLEA=;
        b=7HjE29DsroPJdg9vEIBReECFG4fsFxwk9JWqdDCwA4d9wJV4S8X/OfIBbxDTQN6HJtJU2Q
        fjZiraMgZLXOmIAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1D9413A76;
        Tue, 10 May 2022 00:28:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H8/XHpexeWKlZAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 10 May 2022 00:28:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Miaohe Lin" <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, apopple@nvidia.com, david@redhat.com,
        surenb@google.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linmiaohe@huawei.com
Subject: Re: [PATCH 09/15] mm/swap: avoid calling swp_swap_info when try to
 check SWP_STABLE_WRITES
In-reply-to: <20220509131416.17553-10-linmiaohe@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>,
 <20220509131416.17553-10-linmiaohe@huawei.com>
Date:   Tue, 10 May 2022 10:28:04 +1000
Message-id: <165214248406.14782.6536817483979050668@noble.neil.brown.name>
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
> Use flags of si directly to check SWP_STABLE_WRITES to avoid possible
> READ_ONCE and thus save some cpu cycles.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 9c3e7e6ac202..89dd15504f3d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3892,7 +3892,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			 */
>  			exclusive = true;
>  		} else if (exclusive && PageWriteback(page) &&
> -			  (swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {
> +			  (si->flags & SWP_STABLE_WRITES)) {

Should this have a data_race() annotation.  Other bit-tests of si->flags
do because scan_swap_map_slots can update it asynchronously, but we know
that won't matter in practice.

Thanks,
NeilBrown


>  			/*
>  			 * This is tricky: not all swap backends support
>  			 * concurrent page modifications while under writeback.
> -- 
> 2.23.0
> 
> 
