Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A604BA38E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbiBQOsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:48:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242049AbiBQOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:48:00 -0500
X-Greylist: delayed 137 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 06:47:43 PST
Received: from p3plsmtpa11-04.prod.phx3.secureserver.net (p3plsmtpa11-04.prod.phx3.secureserver.net [68.178.252.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D630615E6E3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:47:43 -0800 (PST)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id Ki28n316uQeWgKi2AnNP8p; Thu, 17 Feb 2022 07:45:26 -0700
X-CMAE-Analysis: v=2.4 cv=Fa7yeLy6 c=1 sm=1 tr=0 ts=620e5f86
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=r5m66G8ZfA9aYF3hFTkA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Thu, 17 Feb 2022 14:45:24 +0000
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>, Phil Auld <pauld@redhat.com>,
        tglx@linutronix.de, mingo@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <20220217144524.el7lwi45hwsf3ef2@ava.usersys.com>
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <YfxVpEO+UJTC+a9e@lorien.usersys.redhat.com>
 <20220216143412.dwxjlkq4w2zeweld@ava.usersys.com>
 <20220217125731.GA744754@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217125731.GA744754@lothringen>
X-CMAE-Envelope: MS4xfLkWofOShUPdAv6/WMzdpwZTNw5VpOKWtXuAJawWtOZ7Rms7HwLXEwraAp/eqA7/7AcSC81edXfGXBhmpxJxyhkrNwi8JMZRHFXhuQv1hiJ/0kYhTy/s
 +aiknQJNXvx3+KiX+0CNIC/8IxRsRwn304CHwtTt4ve0Ibe1yRsLxlw4Mq6OsaJdpiaY6f8B+8sbtlGF22V+TvCV4CzAQkJj3TnbwLk0nhdYAFHZZPR9WK+/
 tiZMQtciczwUoiGX9bs7RT+SyHqtzqIM/3VGnGDM2rGT71izV3WzdTE8queJ5ZTEC8jZ/U00jUXQHehO8cMl+D7czfcG74hFNh1Yw601RSWoNNsI8DNa8Z5D
 trS24NvvmF28cVGHalXRjNIOPWrVQvANrFO/vZf4VAALog3qGeM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-17 13:57 +0100, Frederic Weisbecker wrote:
> Hmm, but does it matter? The issue seem to be that we can enter in idle loop without
> flushing vmstat. Or am I missing something else?
Frederic,

Yes, this is indeed the concern. So, the idea I had was to invoke
quiet_vmstat() regardless if the tick was stopped or not. If I understand
correctly, this should resolve the issue. Furthermore, folding of all
outstanding differentials will only occur when required. Thus performance
should be negligible.


Kind regards,

-- 
Aaron Tomlin
