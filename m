Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DE751DC76
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443117AbiEFPsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358212AbiEFPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:48:06 -0400
Received: from mr85p00im-ztdg06011101.me.com (mr85p00im-ztdg06011101.me.com [17.58.23.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0961568F93
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1651851862; bh=+CCBnZzUUMptTEB5E31LJJ2qM8kVspBxIFEt8rpQAWM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=AArtFYBMwG7CWnZExqc3XKE8kFfPy7L0UitCaXx+DOM8QjELFmgfXMtYb0Rsehqzh
         wIym9qEDfPWhP2uYHVi4LqRqbM6uUDiGCiLaM05acnGKB0IKcHl9F0vVsP5j/64vCi
         ttBH2b9fYdOGlwMASdssX9e0nbpnG9m+pziCKcWTvD3w9a6C2K2sIoqe/tVNIA/JhA
         Q5UiaFz6N6C+F7fGbmH1C8PAWkaj0ECF+Hcb0dTUeQ+O4FvurBdQ9UrXTZvIggP2y2
         LpFy+5hzaXUcGp3N0UvGg6Lfa82q39iL9dZA52sEYsXit708lkclf0t9bNIX6Pp5a8
         mUrAnaXDXvWLQ==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-ztdg06011101.me.com (Postfix) with ESMTPSA id 05797DA0504;
        Fri,  6 May 2022 15:44:21 +0000 (UTC)
From:   Dan Moulding <dmoulding@me.com>
To:     pavel@ucw.cz
Cc:     akpm@linux-foundation.org, corbet@lwn.net, dmoulding@me.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH v2 0/1] Allow setting hostname before userspace starts
Date:   Fri,  6 May 2022 09:44:20 -0600
Message-Id: <20220506154420.26456-1-dmoulding@me.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506072322.GA3925@amd>
References: <20220506072322.GA3925@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vhIztAh_zrA-Bqk8Qdgy362NLq39rH8I
X-Proofpoint-GUID: vhIztAh_zrA-Bqk8Qdgy362NLq39rH8I
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=316 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 6, 2022, at 1:23 AM, Pavel Machek <pavel@ucw.cz> wrote:

> init gets passed command line parameters kernel did not use. So init
> can do that easily.

I agree this is a problem that *can* be delegated to init to solve.
But is it *better* to do that? Why have the kernel pass the the hostname
to the init system, just so that the init system has to pass it back to the
kernel later?

> Plus, there's initrd.

This to me is a reason why it's better for the kernel to do this. If left up
to the init system, it must be sure it gets done correctly both when an
initramfs is used, and when one is not.

P.S. Apologies to anyone who received this twice, my first reply was
bounced by the list servers.

Cheers,

  -- Dan
