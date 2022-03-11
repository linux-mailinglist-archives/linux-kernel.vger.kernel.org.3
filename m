Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDCD4D5DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242679AbiCKIzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241847AbiCKIzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:55:38 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28381BB70E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:54:33 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id n7so8653904oif.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=DddPVEIDoazghkvqa3kgiYVD4CopQfEujLOe2fCtyYs=;
        b=aqyFksFHGrIOIaRkUw98hF8qDNsn4GBqPWUfp2MCfpYwATcuoXNrxhKFU7usWrRErO
         lI5oi6moHJbiZWweFaNsFwCemkhaucQbOqTEoE+ffuMLR/3nUzCDCsvAzFXVG1qAcycM
         +N5sLv/6M5VZKoYfsJxSZzjVUavPGTOdZE+NWA2lArRXwNPiXAKCiMMID1EPinJBWixc
         rHSdxTHTh6aqTtIMFuNzP87XfQVWYHaTkxkzBq9J87ZzjSnjZsBh+jlWgGGpMZYkOomP
         Mdcs71th38DlkD+Re1NrezNcxhAruyfMB/5OeXaBwZxzGfO/a5HFQ21k7slQTXCZr9EQ
         KKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=DddPVEIDoazghkvqa3kgiYVD4CopQfEujLOe2fCtyYs=;
        b=2LMk2AIB9IT4tAi3CYFOcaGqjh5yPPTao/f40O2ak4NBpCeYo5rxgssryEMb3PvmiO
         eGaqI02vZQq2Vhdreot+lcVOdmUz2CpE7J0Y8uCBjQLMI7TvsG+u6aWy82HLu/FYV8VU
         Le+oqFIS9d7LuJL2ERT++s9SSNK4p68h/pq1Nr6Qq/INecTXwQSAigMBGP01tXpb/wix
         ztYZ+TzQQnvFPBDi/KcYm2jV7YnwAGa1q8B0/gFqt4S44tOARoJd/o1nFCke5WxkNQRw
         7FHcFYUEwcIREh0//YGtvc+4eiKKFx7dcya4GqRKJr4x3Z1dl1JJdSxLIZ3NMz/X/J3+
         neqA==
X-Gm-Message-State: AOAM533oPctjOGdfsFcLHM6JwvXcHaYVeYEGzztEJxYR66Y+etrIzJuC
        nBPUJlb9ANtJwQoO8f/VIF2rog==
X-Google-Smtp-Source: ABdhPJzAt8/Lt5d2T3Z9tG7wf/0x2ZJ1Z5rxrgEKzUBiI2CfF4rDZWKgfTyGt3DajO0mvTxQ5tK4fQ==
X-Received: by 2002:a05:6808:1442:b0:2ce:29d3:a764 with SMTP id x2-20020a056808144200b002ce29d3a764mr5714526oiv.26.1646988872238;
        Fri, 11 Mar 2022 00:54:32 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bl16-20020a056808309000b002d43b28a8bdsm3646862oib.14.2022.03.11.00.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 00:54:31 -0800 (PST)
Date:   Fri, 11 Mar 2022 00:54:15 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
In-Reply-To: <105e1620-5cf2-fecd-27e7-21a6045cc3ac@suse.cz>
Message-ID: <173fbbd0-d631-ede7-4641-39ead6531d9@google.com>
References: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com> <20220304184927.vkq6ewn6uqtcesma@revolver> <20220304190531.6giqbnnaka4xhovx@revolver> <6038ebc2-bc88-497d-a3f3-5936726fb023@google.com> <20220305020021.qmwg5dkham4lyz6v@revolver>
 <29eac73-4f94-1688-3834-8bd6687a18@google.com> <20220308160552.d3dlcaclkqnlkzzj@revolver> <6036627b-6110-cc58-ca1-a6f736553dd@google.com> <105e1620-5cf2-fecd-27e7-21a6045cc3ac@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022, Vlastimil Babka wrote:
> On 3/8/22 22:32, Hugh Dickins wrote:
> > On Tue, 8 Mar 2022, Liam Howlett wrote:
> >> 
> >> I must be missing something.  If mpol_equal() isn't sufficient to ensure
> >> we don't need to set_policy(), then why are the other vma_merge() cases
> >> okay - such as madvise_update_vma() and mlock_fixup()?  Won't the mem
> >> policy change in the same way in these cases?
> > 
> > mlock provides a good example to compare.
> > 
> > Mlocking pages is the business of mlock(), and mlock_fixup() needs to
> > attend to mm->locked_vm, and calling something to mark as PageMlocked
> > those pages already in the area now covered by mlock.  But it doesn't
> > need to worry about set_policy(), that's not its business, and is
> > unaffected by mlock changes (though merging of vmas needs mpol_equal()
> > to check that policy is the same, and merging and splitting of vmas
> > need to maintain the refcount of the shared policy if any).
> > 
> > Whereas NUMA mempolicy is the business of mbind(), and mbind_range()
> > needs to attend to vma->vm_policy, and if it's a mapping of something
> > supporting a shared set_policy(), call that to establish the new range
> > on the object mapped.  But it doesn't need to worry about mm->locked_vm
> > or whether pages are Mlocked, that's not its business, and is unaffected
> > by mbind changes (though merging of vmas needs to check VM_LOCKED among
> > other flags to check that they are the same before it can merge).
> 
> So if I understand correctly, we have case 8 of vma_merge():
> 
>     AAAA
> PPPPNNNNXXXX
> becomes
> PPPPXXXXXXXX 8
> 
> N is vma with some old policy different from new_pol
> A is the range where we change to new policy new_pol, which happens to be
> the same as existing policy of X
> Thus vma_merge() extends vma X to include range A - the vma N
> vma_merge() succeeds because it's passed new_pol to do the compatibility
> checks (although N still has the previous policy)

I *think* you have it the wrong way round there: my reading is that
this vma_merge() case 8 was correctly handled before, because in its
case !mpol_equal(vma_policy(vma), new_pol): I think case 8 was being
handled correctly, but the other cases were not.

Or was the comment even correct to reference case 8 especially?

I'm afraid bringing it all back to mind is a bit of an effort: I won't
stake my life on it, perhaps I'm the one who has it the wrong way round.

> 
> Before Hugh's patch we would then realize "oh X already has new_pol, nothing
> to do". Note that this AFAICS doesn't affect actual pages migration between
> nodes, because that happens outside of mbind_range(). But it causes us to
> skip vma_replace_policy(), which causes us to skip vm_ops->set_policy, where
> tmpfs does something important (we could maybe argue that Hugh didn't
> specify the user visible effects of this exactly enough :) what is "leaving
> the new mbind unenforced" - are pages not migrated in this case?).

Went back to check the original (internal) report:
mbind MPOL_BIND on tmpfs can result in allocations on the wrong node.
And it was a genuine practical case, though the finder was kind enough
to distil it down to a minimal sequence (and correctly suggest the fix).

The user visible effect was that the pages got allocated on the local node
(happened to be 0), after the mbind() caller had specifically asked for
them to be allocated on node 1.  There was not any page migration involved
in the case reported: the pages simply got allocated on the wrong node.

And yes, on this patch I should have asked for a
Cc: <stable@vger.kernel.org>

> 
> HTH (if I'm right),
> Vlastimil
