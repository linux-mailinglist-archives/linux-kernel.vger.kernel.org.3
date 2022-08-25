Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78D5A086E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiHYFZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiHYFZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FA09AF85;
        Wed, 24 Aug 2022 22:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D8961802;
        Thu, 25 Aug 2022 05:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8F2C433D6;
        Thu, 25 Aug 2022 05:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661405111;
        bh=aog8FfyJMu7EFSKnqzmTMzR96RIeMPCXntqSbWYTL/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BtPAnp2TAbS47A7KJ+9uWAXXtJT0C3knSANDsHmv0MXWOj4LnZL1Abo8t/Rsh2GUj
         xrvZ7Z7e0yX4wPaGz1UqCBu4orC6HMGQswsGb896tNEK2aSz+4qAkmyvMgXdlrcLoR
         hSkoRqEcqgBoCoeBBGsCYt5tZjq/yNUWx9vPNHVxbT7jeI7eEZ9YIo+cAX1jj6sYP9
         uO7Q5t66yo4UW07y7UVlg2HdcAwCF0VKw+swtdIHMaInt10Cp/3jJ/e/A8Y0TzWSFC
         PRoOKh/DuU15HbtYOlnV3eYEhVxux2aJOOvx4A3tRwkpR940GHQl7a3i2/otMpMlJz
         wolQl5s8fZifA==
Date:   Thu, 25 Aug 2022 08:25:03 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Chatre, Reinette" <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446
 ksgxd+0x1b7/0x1d0
Message-ID: <YwcHnBTlobzSGgTj@kernel.org>
References: <ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de>
 <4253695b-85aa-a2fb-fbf6-718db8b6c20c@molgen.mpg.de>
 <46e3483b-a5ab-2a05-8a28-f9ea87e881c3@intel.com>
 <YwcBN+1Q7JiYC7cb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8FxDQEgijkZug7ON"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YwcBN+1Q7JiYC7cb@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8FxDQEgijkZug7ON
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Aug 25, 2022 at 07:57:30AM +0300, Jarkko Sakkinen wrote:
> On Fri, Aug 19, 2022 at 11:28:24AM -0700, Dave Hansen wrote:
> > On 8/19/22 09:02, Paul Menzel wrote:
> > > On the Dell XPS 13 9370, Linux 5.18.16 prints the warning below:
> > > 
> > > ```
> > > [    0.000000] Linux version 5.18.0-4-amd64
> > > (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-5) 11.3.0, GNU
> > > ld (GNU Binutils for Debian) 2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC
> > > Debian 5.18.16-1 (2022-08-10)
> > > [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.18.0-4-amd64
> > > root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
> > > […]
> > > [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
> > > […]
> > > [    0.235418] sgx: EPC section 0x40200000-0x45f7ffff
> > 
> > Hi Paul,
> > 
> > Would you be able to send the entire dmesg, along with:
> > 
> > 	cat /proc/iomem # (as root)
> > and
> > 	cpuid -1 --raw
> > 
> > I'm suspecting either a BIOS problem.  Reinette (cc'd) also thought this
> > might be a case of the SGX initialization getting a bit too far along
> > when it should have been disabled.
> > 
> > We had some bugs where we didn't stop fast enough after spitting out the
> > "SGX Launch Control is locked..." errors.
> 
> For some reason the pages do not get properly sanitized:
> 
> 	/* sanity check: */
> 	WARN_ON(!list_empty(&sgx_dirty_page_list));
> 
> EPC should be good, given that EREMOVE does not fail.
> If SGX would be disabled, also EREMOVE should fail.

Sorry forgot that in no circumstances we're printing the
error code inside __sgx_sanitize_pages(). I wrote a quick
patch to address this (attached) [*].

Paul,

Any chance to try the patch out? It's pretty hard to attach
e.g. kprobe to grab this info. Does it reproduce every single
time?

Alternatively: what kind of workload is triggering this?
I do own 2020 model XPS13, which might be able to
reproduce the same issue.

[*] Also: https://lore.kernel.org/linux-sgx/20220825051827.246698-1-jarkko@kernel.org/T/#u

BR, Jarkko

--8FxDQEgijkZug7ON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-x86-sgx-Print-EREMOVE-return-value-in-__sgx_sanitize.patch"

From ddccefc8e864bd9973a5445202922b59760d3460 Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Thu, 25 Aug 2022 08:12:30 +0300
Subject: [PATCH] x86/sgx: Print EREMOVE return value in __sgx_sanitize_pages()

In the 2nd run of __sgx_sanitize_pages() print the error
message. All EREMOVE's should succeed. This will allow to
provide some additional clues, if not.

Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 515e2a5f25bb..33354921c59f 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -50,7 +50,7 @@ static LIST_HEAD(sgx_dirty_page_list);
  * from the input list, and made available for the page allocator. SECS pages
  * prepending their children in the input list are left intact.
  */
-static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
+static void __sgx_sanitize_pages(struct list_head *dirty_page_list, bool verbose)
 {
 	struct sgx_epc_page *page;
 	LIST_HEAD(dirty);
@@ -90,6 +90,9 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
 			list_del(&page->list);
 			sgx_free_epc_page(page);
 		} else {
+			if (verbose)
+				pr_err_ratelimited(EREMOVE_ERROR_MESSAGE, ret, ret);
+
 			/* The page is not yet clean - move to the dirty list. */
 			list_move_tail(&page->list, &dirty);
 		}
@@ -394,8 +397,8 @@ static int ksgxd(void *p)
 	 * Sanitize pages in order to recover from kexec(). The 2nd pass is
 	 * required for SECS pages, whose child pages blocked EREMOVE.
 	 */
-	__sgx_sanitize_pages(&sgx_dirty_page_list);
-	__sgx_sanitize_pages(&sgx_dirty_page_list);
+	__sgx_sanitize_pages(&sgx_dirty_page_list, false);
+	__sgx_sanitize_pages(&sgx_dirty_page_list, true);
 
 	/* sanity check: */
 	WARN_ON(!list_empty(&sgx_dirty_page_list));
-- 
2.37.1


--8FxDQEgijkZug7ON--
