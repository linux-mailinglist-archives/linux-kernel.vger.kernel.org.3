Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3915A4D61BD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347473AbiCKMsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiCKMsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:48:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084111B50E6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:47:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B3F7D210F4;
        Fri, 11 Mar 2022 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647002825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uIZs6aXbn1yfSeNvtrbgTb878okfutBst+D7FkC272s=;
        b=s9nMxKW6jxrPK7qq76hQgTON8AqoGOYaAaSplZBc330xVay3feiEfHBceosn1YVK2jYRz9
        4kah91S5OHZ5J0z9M0xIF3P4ve9qZHxPoOp+5SPaSeZtDtoDPTPq2W2fD888Ipj9Bdzffw
        4mohCEIyLjX3gC+FqhKYSrAXQy6QLzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647002825;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uIZs6aXbn1yfSeNvtrbgTb878okfutBst+D7FkC272s=;
        b=9wj0/wIDb4SRo+1WUY+8gJIoFzP83RpwiznJE0zWgetbIxVHDRynK7B145JTY/WL8XVHQP
        akAWuQ6s0kO2D8Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 989C013A85;
        Fri, 11 Mar 2022 12:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rMqKJMlEK2JnPgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Mar 2022 12:47:05 +0000
Message-ID: <27b91006-94f4-2dcb-e796-62e4e553d018@suse.cz>
Date:   Fri, 11 Mar 2022 13:47:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <105e1620-5cf2-fecd-27e7-21a6045cc3ac@suse.cz>
 <173fbbd0-d631-ede7-4641-39ead6531d9@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
In-Reply-To: <173fbbd0-d631-ede7-4641-39ead6531d9@google.com>
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

On 3/11/22 09:54, Hugh Dickins wrote:
> On Wed, 9 Mar 2022, Vlastimil Babka wrote:
>> On 3/8/22 22:32, Hugh Dickins wrote:
>> > On Tue, 8 Mar 2022, Liam Howlett wrote:
>> >> 
>> >> I must be missing something.  If mpol_equal() isn't sufficient to ensure
>> >> we don't need to set_policy(), then why are the other vma_merge() cases
>> >> okay - such as madvise_update_vma() and mlock_fixup()?  Won't the mem
>> >> policy change in the same way in these cases?
>> > 
>> > mlock provides a good example to compare.
>> > 
>> > Mlocking pages is the business of mlock(), and mlock_fixup() needs to
>> > attend to mm->locked_vm, and calling something to mark as PageMlocked
>> > those pages already in the area now covered by mlock.  But it doesn't
>> > need to worry about set_policy(), that's not its business, and is
>> > unaffected by mlock changes (though merging of vmas needs mpol_equal()
>> > to check that policy is the same, and merging and splitting of vmas
>> > need to maintain the refcount of the shared policy if any).
>> > 
>> > Whereas NUMA mempolicy is the business of mbind(), and mbind_range()
>> > needs to attend to vma->vm_policy, and if it's a mapping of something
>> > supporting a shared set_policy(), call that to establish the new range
>> > on the object mapped.  But it doesn't need to worry about mm->locked_vm
>> > or whether pages are Mlocked, that's not its business, and is unaffected
>> > by mbind changes (though merging of vmas needs to check VM_LOCKED among
>> > other flags to check that they are the same before it can merge).
>> 
>> So if I understand correctly, we have case 8 of vma_merge():
>> 
>>     AAAA
>> PPPPNNNNXXXX
>> becomes
>> PPPPXXXXXXXX 8
>> 
>> N is vma with some old policy different from new_pol
>> A is the range where we change to new policy new_pol, which happens to be
>> the same as existing policy of X
>> Thus vma_merge() extends vma X to include range A - the vma N
>> vma_merge() succeeds because it's passed new_pol to do the compatibility
>> checks (although N still has the previous policy)
> 
> I *think* you have it the wrong way round there: my reading is that
> this vma_merge() case 8 was correctly handled before, because in its
> case !mpol_equal(vma_policy(vma), new_pol): I think case 8 was being
> handled correctly, but the other cases were not.
> 
> Or was the comment even correct to reference case 8 especially?

I think it wasn't, but...

> I'm afraid bringing it all back to mind is a bit of an effort: I won't
> stake my life on it, perhaps I'm the one who has it the wrong way round.

... same here.

Importantly I believe your patch is the correct solution.

>> 
>> Before Hugh's patch we would then realize "oh X already has new_pol, nothing
>> to do". Note that this AFAICS doesn't affect actual pages migration between
>> nodes, because that happens outside of mbind_range(). But it causes us to
>> skip vma_replace_policy(), which causes us to skip vm_ops->set_policy, where
>> tmpfs does something important (we could maybe argue that Hugh didn't
>> specify the user visible effects of this exactly enough :) what is "leaving
>> the new mbind unenforced" - are pages not migrated in this case?).
> 
> Went back to check the original (internal) report:
> mbind MPOL_BIND on tmpfs can result in allocations on the wrong node.
> And it was a genuine practical case, though the finder was kind enough
> to distil it down to a minimal sequence (and correctly suggest the fix).
> 
> The user visible effect was that the pages got allocated on the local node
> (happened to be 0), after the mbind() caller had specifically asked for
> them to be allocated on node 1.  There was not any page migration involved
> in the case reported: the pages simply got allocated on the wrong node.

That's useful, thanks.

> And yes, on this patch I should have asked for a
> Cc: <stable@vger.kernel.org>

Agree. Andrew can add it, and also the user visible effects above?

Thanks,
Vlastimil

>> 
>> HTH (if I'm right),
>> Vlastimil

