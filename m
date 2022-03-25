Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959824E6FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356052AbiCYJAR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Mar 2022 05:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCYJAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:00:16 -0400
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Mar 2022 01:58:41 PDT
Received: from mail.sysgo.com (mail.sysgo.com [IPv6:2a01:4f8:fff0:cf:2::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40D3377FE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 01:58:41 -0700 (PDT)
From:   Matthias Welwarsky <matthias.welwarsky@sysgo.com>
To:     linux-kernel@vger.kernel.org
Subject: x86, possible bug in __memmove() alternatives patching
Date:   Fri, 25 Mar 2022 09:51:09 +0100
Message-ID: <3422754.iIbC2pHGDl@linux-3513>
Organization: SYSGO GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I've come across an odd behavior that I'm not sure whether it counts as a bug.
I'm working on an x86 hypervisor at the moment and there was an odd problem 
with a linux guest system dying during booting, but only on an intel NUC11 
(i3-1115G4). It booted normally on any other system I tested on.

The guest was usin kernel version 5.10.89.

Now, the reason eventually turned out to be __memmove() getting broken when 
applying the alternatives. The CPU on the NUC11 has the FSRM feature, which 
enables a particular alternative in __memmove(). However, the code assumes 
that the ERMS feature is always present with FSRM, otherwise the function gets 
broken. Of course this is normally the case, a CPU without ERMS would never 
advertise FSRM.

However: in the function early_intel_setup(), the ERMS feature might get 
cleared depending on the IA32_MISC_ENABLE MSR: if fast string operations are 
disabled through this MSR, X86_FEATURE_ERMS is removed from the available set, 
but X86_FEATURE_FSRM is not removed.

Now, the hypervisor I'm working on emulates this MSR and in the particular 
case, fast string ops were reported as disabled, leading to the above 
mentioned inconsistency in __memmove().

The Intel SDM doesn't go into any details if disabling fast string ops through 
IA32_MISC_ENABLE will also clear FSRM from cpuid leaf 7, but I think that's 
not relevant for the linux kernel anyway because cpuid is parsed before MSRs 
are evaluated.

I know it's is probably a very rare case and Intel recommends having fast 
string ops enabled, hence the question: would this be considered a bug in the 
kernel that should be fixed? A potential fix could be to clear FSRM together 
with ERMS depending on IA32_MISC_ENABLE.


Mit freundlichen Grüßen/Best regards,

Matthias Welwarsky
Project Engineer

SYSGO GmbH
Office Mainz
Am Pfaffenstein 8 / D-55270 Klein-Winternheim / Germany
Phone: +49-6136-9948-0 / Fax: +49-6136-9948-10
E-mail: matthias.welwarsky@sysgo.com
_________________________________________________________________________________
Web: https://www.sysgo.com
Blog: https://www.sysgo.com/blog
Events: https://www.sysgo.com/events
Newsletter: https://www.sysgo.com/newsletter
_________________________________________________________________________________
Handelsregister/Commercial Registry: HRB Mainz 90 HRB 48884 
Geschäftsführung/Managing Directors: Etienne Butery (CEO), Kai Sablotny (COO) 
USt-Id-Nr./VAT-Id-No.: DE 149062328 

The protection of your personal data is important to us. Under the following 
link 
you can see the information in accordance with article 13 GDPR: 
https://www.sysgo.com/privacy_policy


