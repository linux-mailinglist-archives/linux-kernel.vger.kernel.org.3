Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3915063C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348487AbiDSFPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiDSFPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:15:31 -0400
X-Greylist: delayed 1138 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Apr 2022 22:12:49 PDT
Received: from gherkin.frus.com (cpe-67-11-228-40.satx.res.rr.com [67.11.228.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF995220C1;
        Mon, 18 Apr 2022 22:12:49 -0700 (PDT)
Received: by gherkin.frus.com (Postfix, from userid 500)
        id 485DF61DAA; Mon, 18 Apr 2022 23:53:50 -0500 (CDT)
Date:   Mon, 18 Apr 2022 23:53:50 -0500
From:   Bob Tracy <rct@frus.com>
To:     debian-alpha@lists.debian.org
Cc:     Michael Cree <mcree@orcon.net.nz>, linux-alpha@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 5.17.0 boot issue on Miata
Message-ID: <Yl5AXvU+cBH5ex4K@gherkin.frus.com>
References: <Yj0u150JJpsb9nj4@gherkin.frus.com>
 <20220326222157.GA13650@tower>
 <YkuejknyPDJoQEDC@gherkin.frus.com>
 <20220405050125.GA25969@tower>
 <YkxKRElYUhMgOOCN@gherkin.frus.com>
 <10d61d8f-edfc-fc39-0936-233692464dbd@gmx.de>
 <Yk4XsdHvjrLqN1LR@gherkin.frus.com>
 <YlAyZdZ6afL58Ege@gherkin.frus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlAyZdZ6afL58Ege@gherkin.frus.com>
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding linux-scsi and linux-kernel, now that bisection is complete.)

On Wed, Apr 06, 2022 at 05:44:01PM -0500, Bob Tracy wrote:
> v5.17-rc2 ok.  v5.17-rc3 I get the disk sector errors and hang that I
> reported in the first message in this thread.

This is on an Alpha Miata platform (PWS 433au) with QLogic ISP1020 controller.

Here's the implicated commit:

edb854a3680bacc9ef9b91ec0c5ff6105886f6f3 is the first bad commit
commit edb854a3680bacc9ef9b91ec0c5ff6105886f6f3
Author: Ming Lei <ming.lei@redhat.com>
Date:   Thu Jan 27 23:37:33 2022 +0800

    scsi: core: Reallocate device's budget map on queue depth change
    
    We currently use ->cmd_per_lun as initial queue depth for setting up the
    budget_map. Martin Wilck reported that it is common for the queue_depth to
    be subsequently updated in slave_configure() based on detected hardware
    characteristics.
    
    As a result, for some drivers, the static host template settings for
    cmd_per_lun and can_queue won't actually get used in practice. And if the
    default values are used to allocate the budget_map, memory may be consumed
    unnecessarily.
    
    Fix the issue by reallocating the budget_map after ->slave_configure()
    returns. At that time the device queue_depth should accurately reflect what
    the hardware needs.
    
    Link: https://lore.kernel.org/r/20220127153733.409132-1-ming.lei@redhat.com
    Cc: Bart Van Assche <bvanassche@acm.org>
    Reported-by: Martin Wilck <martin.wilck@suse.com>
    Suggested-by: Martin Wilck <martin.wilck@suse.com>
    Tested-by: Martin Wilck <mwilck@suse.com>
    Reviewed-by: Martin Wilck <mwilck@suse.com>
    Reviewed-by: Bart Van Assche <bvanassche@acm.org>
    Signed-off-by: Ming Lei <ming.lei@redhat.com>
    Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

 drivers/scsi/scsi_scan.c | 55 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 5 deletions(-)

 Respectfully,
 --Bob
