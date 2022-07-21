Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC4857CCAE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiGUNut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiGUNu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:50:28 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A1434CE38
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:50:23 -0700 (PDT)
Received: (qmail 230363 invoked by uid 1000); 21 Jul 2022 09:50:23 -0400
Date:   Thu, 21 Jul 2022 09:50:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Cc:     gregkh@linuxfoundation.org, kishon@ti.com, dianders@chromium.org,
        s.shtylyov@omp.ru, mka@chromium.org, ming.lei@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        tonywwang@zhaoxin.com, weitaowang@zhaoxin.com,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com
Subject: Re: [PATCH] USB: HCD: Fix URB giveback issue in tasklet function
Message-ID: <YtlZn74MDEj+1On9@rowland.harvard.edu>
References: <20220721060833.4173-1-WeitaoWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721060833.4173-1-WeitaoWang-oc@zhaoxin.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 02:08:33PM +0800, Weitao Wang wrote:
> Usb core introduce the mechanism of giveback of URB in tasklet context to
> reduce hardware interrupt handling time. On some test situation(such as
> FIO with 4KB block size), when tasklet callback function called to
> giveback URB, interrupt handler add URB node to the bh->head list also.
> If check bh->head list again after finish all URB giveback of local_list,
> then it may introduce a "dynamic balance" between giveback URB and add URB
> to bh->head list. This tasklet callback function may not exit for a long
> time, which will cause other tasklet function calls to be delayed. Some
> real-time applications(such as KB and Mouse) will see noticeable lag.
> 
> Fix this issue by taking new URBs giveback in next tasklet function call.

The patch also replaces the local high_prio_bh variable with a new
bh->high_prio structure member.  This should be mentioned in the patch 
description.

Alan Stern
