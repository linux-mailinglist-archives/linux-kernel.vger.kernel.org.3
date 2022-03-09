Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2844D2F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiCIMmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiCIMmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:42:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C4D1768EF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:41:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 58FBF1F381;
        Wed,  9 Mar 2022 12:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646829704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8Hk1US5ALaJqROKDmhS5n/mU774qzqXx0l8GfBy25Q=;
        b=S3cCmYevcge2i3KzDINHS821CqzPoY5g8kr8ONVETVsoO/xqtxHgFCXR/n8YfampCsLqhs
        Um9WKgHtiWSL9WqnkGTCnLiSmGLcFDZyxh/YzbvBQg1X6V+XPRE52QriJPjrVxzuKhJHH1
        DQakS0ebltreZU2V56HHO92t1OX1xLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646829704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8Hk1US5ALaJqROKDmhS5n/mU774qzqXx0l8GfBy25Q=;
        b=vXG6v5OTi7xjoT7gDdoCiQKs1fmoVBRY1h5gNC3VWquG1E2LmqxnJwHX3BrgD4sA8egMtL
        3L3wFDb9fmoPbBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AF0613D79;
        Wed,  9 Mar 2022 12:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HtSBDYigKGL7CQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 09 Mar 2022 12:41:44 +0000
Message-ID: <105e1620-5cf2-fecd-27e7-21a6045cc3ac@suse.cz>
Date:   Wed, 9 Mar 2022 13:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com>
 <20220304184927.vkq6ewn6uqtcesma@revolver>
 <20220304190531.6giqbnnaka4xhovx@revolver>
 <6038ebc2-bc88-497d-a3f3-5936726fb023@google.com>
 <20220305020021.qmwg5dkham4lyz6v@revolver>
 <29eac73-4f94-1688-3834-8bd6687a18@google.com>
 <20220308160552.d3dlcaclkqnlkzzj@revolver>
 <6036627b-6110-cc58-ca1-a6f736553dd@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
In-Reply-To: <6036627b-6110-cc58-ca1-a6f736553dd@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 22:32, Hugh Dickins wrote:
> On Tue, 8 Mar 2022, Liam Howlett wrote:
>> * Hugh Dickins <hughd@google.com> [220304 21:29]:
>> > On Sat, 5 Mar 2022, Liam Howlett wrote:
>> > > * Hugh Dickins <hughd@google.com> [220304 17:48]:
>> > > > On Fri, 4 Mar 2022, Liam Howlett wrote:
>> > > > > * Liam R. Howlett <Liam.Howlett@Oracle.com> [220304 13:49]:
>> > > > > > * Hugh Dickins <hughd@google.com> [220303 23:36]:
>> > > > > 
>> > > > > I just thought of something after my initial email
>> > > > > 
>> > > > > How does the ->set_policy() requirement on tmpfs play out for the
>> > > > > mpol_equal() check earlier in that for loop?
>> > > > 
>> > > > It took me a while to page all this back in (and remind myself of
>> > > > what is case 8) to answer that question!
>> > > > 
>> > > > The answer is that the mpol_equal() check at the top of the loop is on
>> > > > an existing, unmodified vma; so it's right to assume that any necessary
>> > > > set_policy() has already been done.
>> > > > 
>> > > > Whereas the mpol_equal() check being removed in this patch, is being
>> > > > done on a vma which may have just been extended to cover a greater range:
>> > > > so although the relevant set_policy() may have already been done on a part
>> > > > of its range, there is now another part which needs the policy applied.
>> > > 
>> > > Doesn't the policy get checked during vma_merge()?  Specifically the
>> > > mpol_equal(policy, vma_policy(next)) check?
>> > 
>> > Sorry, I'm reduced to the unhelpful reply of "Yes. So?"
>> > 
>> > If vma_merge() finds that vma's new_pol allows it to be merged with prev,
>> > that still requires mbind_range() (or its call to vma_replace_policy())
>> > to set_policy() on prev (now assigned to vma), to apply that new_pol to
>> > the extension of prev - vma_merge() would have checked mpol_equal(),
>> > but would not have done the set_policy().
>> 
>> I must be missing something.  If mpol_equal() isn't sufficient to ensure
>> we don't need to set_policy(), then why are the other vma_merge() cases
>> okay - such as madvise_update_vma() and mlock_fixup()?  Won't the mem
>> policy change in the same way in these cases?
> 
> mlock provides a good example to compare.
> 
> Mlocking pages is the business of mlock(), and mlock_fixup() needs to
> attend to mm->locked_vm, and calling something to mark as PageMlocked
> those pages already in the area now covered by mlock.  But it doesn't
> need to worry about set_policy(), that's not its business, and is
> unaffected by mlock changes (though merging of vmas needs mpol_equal()
> to check that policy is the same, and merging and splitting of vmas
> need to maintain the refcount of the shared policy if any).
> 
> Whereas NUMA mempolicy is the business of mbind(), and mbind_range()
> needs to attend to vma->vm_policy, and if it's a mapping of something
> supporting a shared set_policy(), call that to establish the new range
> on the object mapped.  But it doesn't need to worry about mm->locked_vm
> or whether pages are Mlocked, that's not its business, and is unaffected
> by mbind changes (though merging of vmas needs to check VM_LOCKED among
> other flags to check that they are the same before it can merge).

So if I understand correctly, we have case 8 of vma_merge():

    AAAA
PPPPNNNNXXXX
becomes
PPPPXXXXXXXX 8

N is vma with some old policy different from new_pol
A is the range where we change to new policy new_pol, which happens to be
the same as existing policy of X
Thus vma_merge() extends vma X to include range A - the vma N
vma_merge() succeeds because it's passed new_pol to do the compatibility
checks (although N still has the previous policy)

Before Hugh's patch we would then realize "oh X already has new_pol, nothing
to do". Note that this AFAICS doesn't affect actual pages migration between
nodes, because that happens outside of mbind_range(). But it causes us to
skip vma_replace_policy(), which causes us to skip vm_ops->set_policy, where
tmpfs does something important (we could maybe argue that Hugh didn't
specify the user visible effects of this exactly enough :) what is "leaving
the new mbind unenforced" - are pages not migrated in this case?).

HTH (if I'm right),
Vlastimil

> Does that help?
> 
> Hugh
> 

