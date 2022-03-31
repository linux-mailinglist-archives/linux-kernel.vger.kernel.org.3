Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145984EE2B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbiCaUgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241360AbiCaUgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:36:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C2792D28;
        Thu, 31 Mar 2022 13:34:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74601B82235;
        Thu, 31 Mar 2022 20:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A59C340ED;
        Thu, 31 Mar 2022 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648758884;
        bh=jmwDHcChvd6o9vgnef1gEpL170XClXlVn3dwuMj7F1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSa+IR/f6DBLmuEMOVL4n06uZZu+IsodIGNuPhB+EGQZ5GqHUE6ahDO0elkj/jhe3
         mnI4X5a0SwfiJjIgjSi6HghwixhChIBali3370ZCFsqbcnzg4bav6N3WPtjhmp3vdx
         bXI5H7T4yase3U1rKjl0kXwLEwZQlmjBwfoqQ8SOc4hZaIcSX6CwHYfuT2K9h5LWoR
         2coXB6kc4z8Qcrbp6POCflbjvexTX5qQYVqfRUr9MSn6B5IInVAzKMmzhz2ErGBm7z
         jLxKOGIVx/LX2vzGT2OJtyX/tMDeKOmi2PcBdrnox2auCad6flSL2oFXFJPWjl0GhM
         FtBffHY9Z1SeQ==
Date:   Thu, 31 Mar 2022 15:43:24 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] lib: zstd: Fix Wstringop-overflow warning
Message-ID: <20220331204324.GA167652@embeddedor>
References: <20220330193352.GA119296@embeddedor>
 <202203301416.568595B87@keescook>
 <AC568A96-E2E3-4A56-B993-05ED7B5326AF@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AC568A96-E2E3-4A56-B993-05ED7B5326AF@fb.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 07:55:04PM +0000, Nick Terrell wrote:
> 
> 
> > On Mar 30, 2022, at 2:43 PM, Kees Cook <keescook@chromium.org> wrote:
> > 
> > On Wed, Mar 30, 2022 at 02:33:52PM -0500, Gustavo A. R. Silva wrote:
> >> Fix the following -Wstringop-overflow warning when building with GCC-11:
> >> 
> >> lib/zstd/decompress/huf_decompress.c: In function ‘HUF_readDTableX2_wksp’:
> >> lib/zstd/decompress/huf_decompress.c:700:5: warning: ‘HUF_fillDTableX2.constprop’ accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]
> >>  700 |     HUF_fillDTableX2(dt, maxTableLog,
> >>      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>  701 |                    wksp->sortedSymbol, sizeOfSort,
> >>      |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>  702 |                    wksp->rankStart0, wksp->rankVal, maxW,
> >>      |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>  703 |                    tableLog+1,
> >>      |                    ~~~~~~~~~~~
> >>  704 |                    wksp->calleeWksp, sizeof(wksp->calleeWksp) / sizeof(U32));
> >>      |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> lib/zstd/decompress/huf_decompress.c:700:5: note: referencing argument 6 of type ‘U32 (*)[13]’ {aka ‘unsigned int (*)[13]’}
> >> lib/zstd/decompress/huf_decompress.c:571:13: note: in a call to function ‘HUF_fillDTableX2.constprop’
> >>  571 | static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
> >>      |             ^~~~~~~~~~~~~~~~
> > 
> > Reviewing this changes would be easier if the reason for the warning
> > could be explained. i.e. why has GCC decided that the region is 52
> > bytes, and how did it calculate the 624 bytes?
> > 
> > rankVal_t is HUF_TABLELOG_MAX-many rankValCol_t, which itself is
> > HUF_TABLELOG_MAX + 1 many U32s. So, basically:
> > 
> > U32 array[HUF_TABLELOG_MAX + 1][HUF_TABLELOG_MAX]

I think this is U32 array[HUF_TABLELOG_MAX][HUF_TABLELOG_MAX + 1]

> > 
> > sizeof(rankValCol_t) == 52
> > sizeof(rankVal_t) == 624

Yep;

> 
> Yeah, I'm not quite sure what this warning is saying. Clarification would
> be useful. It seems like a false positive to me, but I could be mistaken.
> 
> >> 
> >> by using pointer notation instead of array notation.
> >> 
> >> This helps with the ongoing efforts to globally enable
> >> -Wstringop-overflow.
> >> 
> >> Link: https://github.com/KSPP/linux/issues/181
> >> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >> ---
> >> lib/zstd/decompress/huf_decompress.c | 6 +++---
> >> 1 file changed, 3 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/lib/zstd/decompress/huf_decompress.c b/lib/zstd/decompress/huf_decompress.c
> >> index 5105e59ac04a..0ea34621253a 100644
> >> --- a/lib/zstd/decompress/huf_decompress.c
> >> +++ b/lib/zstd/decompress/huf_decompress.c
> >> @@ -570,7 +570,7 @@ static void HUF_fillDTableX2Level2(HUF_DEltX2* DTable, U32 sizeLog, const U32 co
> >> 
> >> static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
> >>                            const sortedSymbol_t* sortedList, const U32 sortedListSize,
> >> -                           const U32* rankStart, rankVal_t rankValOrigin, const U32 maxWeight,
> >> +                           const U32* rankStart, const U32* rankValOrigin, const U32 maxWeight,
> >>                            const U32 nbBitsBaseline, U32* wksp, size_t wkspSize)
> > 
> > This really feels like we're papering over the warning. This removes the
> > type information and makes it a U32 * instead, and then later makes a
> > cast?
> > 
> > Can this be fixed in a way that retains the type information?
> > 
> > On the other hand, all the arguments are also U32 *.
> > 
> > I see stuff like:
> > 
> >    ZSTD_memcpy(rankVal, rankValOrigin, sizeof(U32) * (HUF_TABLELOG_MAX + 1));
> > 
> > That looks like it's ignoring type information as well. i.e. why isn't
> > this sizeof(rankValOrigin)? (The length above is 52 bytes.)
> > 
> > I'm especially curious here since rankValOrigin is rankVal_t, which is
> > 624 bytes, not 52 bytes (i.e. the above is copying a single rankValCol_t
> > from rankValOrigin. I'd expect this to be:
> > 
> >    ZSTD_memcpy(rankVal, &rankValOrigin[0], sizeof(rankValOrigin[0]));
> 
> Yes, this is definitely a better way to write it. But, I think the `&` is unnecessary.
> Because of the way C arrays work, rankValOrigin == rankValOrigin[0].
> 
> Upstream, this memcpy is gone, and this code has been optimized & refactored [1].
> And that will get pulled in in the next update. But, in the meantime, I'd be happy to
> accept a refactoring diff.
> 
> [0] https://gcc.godbolt.org/z/orodoK818
> [1] https://github.com/facebook/zstd/blob/3e6bbdd8473a753d2047969ac0053fb2cb4dda23/lib/decompress/huf_decompress.c#L992-L1036
> 
> >> {
> >>     U32* rankVal = wksp;
> >> @@ -598,7 +598,7 @@ static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
> >>             if (minWeight < 1) minWeight = 1;
> >>             sortedRank = rankStart[minWeight];
> >>             HUF_fillDTableX2Level2(DTable+start, targetLog-nbBits, nbBits,
> >> -                           rankValOrigin[nbBits], minWeight,
> >> +                           rankValOrigin + nbBits, minWeight,
> > 
> > And here I'd expect to pass	&rankValOrigin[nbBits]

In this case &rankValOrigin[nbBits] (array notation) is equivalent to
rankValOrigin + nbBits (pointer arithmetic notation).

> > since HUF_fillDTableX2Level2 is doing another rankValCol_t-sized copy:
> > 
> >    ZSTD_memcpy(rankVal, rankValOrigin, sizeof(U32) * (HUF_TABLELOG_MAX + 1));
> 
> In HUF_fillDTableX2Level2, rankValOrigin is a rankValCol_t. It is confusing, and this
> is improved upstream, though rankVal is passed as a U32 const*, where it should really
> Be a rankValCol_t. So I'll put up a small PR to improve that upstream.
> 
> >>                            sortedList+sortedRank, sortedListSize-sortedRank,
> >>                            nbBitsBaseline, symbol, wksp, wkspSize);
> >>         } else {
> >> @@ -699,7 +699,7 @@ size_t HUF_readDTableX2_wksp(HUF_DTable* DTable,
> >> 
> >>     HUF_fillDTableX2(dt, maxTableLog,
> >>                    wksp->sortedSymbol, sizeOfSort,
> >> -                   wksp->rankStart0, wksp->rankVal, maxW,
> >> +                   wksp->rankStart0, (U32 *)wksp->rankVal, maxW,
> > 
> > It's possible the problem is with this structure:
> > 
> > typedef struct {
> >    rankValCol_t rankVal[HUF_TABLELOG_MAX];
> >    U32 rankStats[HUF_TABLELOG_MAX + 1];
> >    U32 rankStart0[HUF_TABLELOG_MAX + 2];
> >    sortedSymbol_t sortedSymbol[HUF_SYMBOLVALUE_MAX + 1];
> >    BYTE weightList[HUF_SYMBOLVALUE_MAX + 1];
> >    U32 calleeWksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
> > } HUF_ReadDTableX2_Workspace;
> > 
> > it's not using the rankVal_t type for rankVal for some reason?
> > 
> > i.e. what's passed to HUF_fillDTableX2 is a rankValCol_t (52 bytes), but then it
> > gets passed against later as rankVal_t (624 bytes).
> > 
> > Does changing the type definition above solve this more cleanly?

I noticed exactly the same thing. However, changing the type definiton
required extra refactoring that at that moment I wasn't sure it was
the correct thing to do. So, this definitely needed some comments from
the maintainer.

> 
> It would make sense to refactor it as a `rankVal_t` to me, since that is
> consistent with the function signature. However, after removing typedefs,
> `wksp->rankVal` should be exactly the same type as `rankVal_t`. So the
> warning seems too noisy here.
> 
> Not saying that the code can't be improved, it certainly can be, and I will
> put up a PR upstream by tomorrow, and link it here.

That'd be great, Nick! :)

Thank you both Kees and Nick for the feedback.
--
Gustavo
