Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB90357C0E6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiGTXcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiGTXcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:32:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7286B247
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88C55B82237
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FD4C341C7;
        Wed, 20 Jul 2022 23:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658359965;
        bh=eg3Si/uRSB1XNZ7q5athr0sUXt8awv2QjY8nOnATEvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UoWgP4DI30cDMfzXJsnQJCeP2ZjRURbQJVfwKzGClFMbTFVyHx+nYE+8tHvFDMnw/
         cOJ9IgJPngwsBjIdEVMAJI6uxBspFaRCDyaxJBFKL+iDES6KI91kwqvMIsvRtaXYv7
         l8RmI6lYZY9Py6RNm4KpybkB5nsbSbARKvC9d3+DfJGZ4d9iqiTAZhglLSmSw+8qIA
         MTRzbQlUXPCA1LgeJVvkh6QRp2hN81L9jbBtGi4OpaIA0wU5dWJHyxOyHRi1lvaQ+8
         g5OfCp/mZ4IimvO1kmDe0EjVItQLzRlvevQgrmJ5s7OnlmBraVcd5NW8AGCG8ONvGB
         HcRwYT0+iJX9Q==
Date:   Wed, 20 Jul 2022 16:32:43 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     keescook@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: faddr2line issue
Message-ID: <20220720233243.lyjrhi43bwaxecm3@treble>
References: <09df26a9-27af-1276-34c6-820bf7e27da8@huawei.com>
 <3492d341-a681-f344-f5cd-5b1ea3725f31@huawei.com>
 <20220714164136.n2ycc5axt7vtctgs@treble>
 <64da0019-4816-a409-be93-b1cf7021c584@huawei.com>
 <20220720000654.yospyvbrfliy3lrn@treble>
 <3bd9817d-1959-c081-e5d0-8b0e70b3f41e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3bd9817d-1959-c081-e5d0-8b0e70b3f41e@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 09:39:42AM +0100, John Garry wrote:
> On 20/07/2022 01:06, Josh Poimboeuf wrote:
> > > So adding config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT to v5.19-rc2 got it
> > > working again for me on arm64. However commit dcea997beed6 ("faddr2line: Fix
> > > overlapping text section failures, the sequel") seems to be broken for me,
> > > below - this first appeared in rc3. Any idea what the issue could be?
> > > 
> > > $./faddr.sh hisi_sas_sata_done+0x8/0x38
> > > hisi_sas_sata_done+0x8/0x38:
> > > fs mm ??:0
> > Hm, what does faddr.sh do?
> 
> ah, it's just a wrapper to call scripts/faddr2line with vmlinux and $1
> (being hisi_sas_sata_done+0x8/0x38, above) args
> 
> > Does addr2line also fail?
> 
> faddr2line fails, as below.
> 
> > 
> > Can you run
> > 
> >    bash -x scripts/faddr2line <vmlinux or .ko file> hisi_sas_sata_done+0x8/0x38
> > 
> > and share the output?
> 
> on rc3 we get:
> 
> https://raw.githubusercontent.com/hisilicon/kernel-dev/private-topic-sas-5.19-faddr2line-linux-rc3/before2

Does this fix it?

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 94ed98dd899f..57099687e5e1 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -112,7 +112,9 @@ __faddr2line() {
 	# section offsets.
 	local file_type=$(${READELF} --file-header $objfile |
 		${AWK} '$1 == "Type:" { print $2; exit }')
-	[[ $file_type = "EXEC" ]] && is_vmlinux=1
+	if [[ $file_type = "EXEC" ]] || [[ $file_type == "DYN" ]]; then
+		is_vmlinux=1
+	fi
 
 	# Go through each of the object's symbols which match the func name.
 	# In rare cases there might be duplicates, in which case we print all
