Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5924E517417
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386286AbiEBQVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355099AbiEBQVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:21:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14ADE0A7
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95CB6612CE
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65977C385A4;
        Mon,  2 May 2022 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651508294;
        bh=M6o+XxaxmZ2PAVL435U0BCsvOvNrKswGfCIA9dmiNo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7vn5MSZNXpDr3O2iJhQUUj/gESuFXrOrdS0BNi1WkLYksKH+TvxNX+7Av0qnsjgn
         JgrQrFQY032Tcm09Eb+L+/4r1NAP9BtNYIgBJWjcKtOG2qqYeVpsEiatJsfqEfDGg/
         Lks+1xoHZ7cifriyBOIg36JtCqdcAiporuo+Mnnl/+0s7VvpLFOVzHbdIfYp/XHi1O
         Jj1DFF0ybIZhxxwXA9yYJRCsptVZW2aMeZtzB8FSMd7lEmFJOQt8hQ9bwaVffPBRc8
         xmJC86N28swQ6ABtsEBDOn9iL9Z80D0PSR+j845VLogYADuVMb/n1BZAOrCxm3zgRY
         MpUCZzYXj7S4Q==
From:   SeongJae Park <sj@kernel.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/damon/sysfs: support fixed virtual address ranges monitoring
Date:   Mon,  2 May 2022 16:18:10 +0000
Message-Id: <20220502161810.134199-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <80586516-d783-8f81-f6d7-338d9af7a3e6@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rongwei,

On Mon, 2 May 2022 15:56:58 +0800 Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:

> Hi, SeongJae
> 
> I had read and tested your patchset these days. It works.

Thank you for the tests! :D

> It seems that these patches only fix the issue about init_regions in 
> DAMON-sysfs, but not fix in DAMON-dbgfs? maybe I missing something.
> 
> If so, do you have any plan to fix this bug in dbgfs? Actually, what I 
> want to say is that I ready a patch for solving the init_regions related 
> bug in dbgfs these days. I not sure if you're interested in it.

The plan is to freeze DAMON debugfs interface after DAMON sysfs interface is
merged, and then entirely remove it after next LTS kernel.  It was mentioned in
the sysfs interface patchset as below:
https://lore.kernel.org/linux-mm/20220228081314.5770-1-sj@kernel.org/

    Future Plan of DAMON_DBGFS Deprecation
    ======================================
    
    Once this patchset is merged, DAMON_DBGFS development will be frozen.  That is,
    we will maintain it to work as is now so that no users will be break.  But, it
    will not be extended to provide any new feature of DAMON.  The support will be
    continued only until next LTS release.  After that, we will drop DAMON_DBGFS.

The plan was also shared in the kernel doc as below[1], but maybe it was too
small to read, or ambiguous.  Sorry if it was the case.

    debugfs interface. This is almost identical to sysfs interface. This will
    be _removed_ after next LTS kernel is released, so users should move to the
    sysfs interface.

[1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#debugfs-interface

So, I don't have a big interest at extending DAMON debugfs for fvaddr.  That
said, of course we could discuss more if you really need it.  If so, please let
me know.


Thanks,
SJ

> 
> Best Regards,
> Rongwei
> 
