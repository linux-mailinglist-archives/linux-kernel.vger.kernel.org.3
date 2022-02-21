Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A3A4BE212
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380932AbiBUQnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:43:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiBUQnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:43:32 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 219881EC6B;
        Mon, 21 Feb 2022 08:43:09 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 507BA92009C; Mon, 21 Feb 2022 17:43:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 49BE692009B;
        Mon, 21 Feb 2022 16:43:07 +0000 (GMT)
Date:   Mon, 21 Feb 2022 16:43:07 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenhuacai@kernel.org, tsbogend@alpha.franken.de
Subject: Re: [RFC PATCH 3/3] MIPS: io.h: Remove barriers before MMIO accessors
 for CPU without WB
In-Reply-To: <20220221145531.10479-4-jiaxun.yang@flygoat.com>
Message-ID: <alpine.DEB.2.21.2202211612440.56785@angie.orcam.me.uk>
References: <20220221145531.10479-1-jiaxun.yang@flygoat.com> <20220221145531.10479-4-jiaxun.yang@flygoat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022, Jiaxun Yang wrote:

> Commit 3d474da ("MIPS: Enforce strong ordering for MMIO accessors")

 Please follow the canonical commit reference format including a 12-digit 
hexadecimal hash reference (`scripts/checkpatch.pl' would have pointed it 
out).

> SYNC based barrier is very heavy on Loongson and MTI cores as it will
> issue a SYNC command on their bus and invalidate all present instrutions
> in pipeline. We should generally avoid that.

 Use whatever lighterweight barrier instruction you have available for 
your specific platforms then that fulfills the ordering enforcement 
required here for your specific platforms of concern that you have 
identified and know well rather than across the board.  The reason for 
this is this is an optimisation and the default barrier model needs to 
ensure correct execution with any implementation.

  Maciej
