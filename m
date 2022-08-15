Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBA2594A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 02:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353099AbiHOXVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 19:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344206AbiHOXO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 19:14:29 -0400
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823D3C36
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:01:49 -0700 (PDT)
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
        by cmsmtp with ESMTP
        id NafDohA5SSp39NgHUoo5D8; Mon, 15 Aug 2022 20:01:48 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
        by cmsmtp with ESMTP
        id NgHTohIc5uJwwNgHTo2TQk; Mon, 15 Aug 2022 20:01:48 +0000
X-Authority-Analysis: v=2.4 cv=F+BEy4tN c=1 sm=1 tr=0 ts=62faa62c
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=biHskzXt2R4A:10 a=M51BFTxLslgA:10 a=nlC_4_pT8q9DhB4Ho9EA:9 a=cm27Pg_UAAAA:8
 a=rTkU1oqxSLEUetzfa08A:9 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
Received: from CLUIJ (cluij.tuyoix.net [192.168.144.15])
        (authenticated bits=0)
        by fanir.tuyoix.net (8.17.1/8.17.1) with ESMTPSA id 27FK1jhk021792
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 15 Aug 2022 14:01:45 -0600
Date:   Mon, 15 Aug 2022 14:01:35 -0600 (Mountain Daylight Time)
From:   =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To:     John Ogness <john.ogness@linutronix.de>
cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] printk: Export log_buf_len to userland
In-Reply-To: <87wnb9pk8k.fsf@jogness.linutronix.de>
Message-ID: <alpine.WNT.2.20.2208151359540.1956@CLUIJ>
References: <a41b5ad3-d052-49b8-e038-b020c1dc6788@tuyoix.net> <YvmsNEYPtdOUsaxy@google.com> <87wnb9pk8k.fsf@jogness.linutronix.de>
User-Agent: Alpine 2.20 (WNT 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="115511-10179-1660593697=:1956"
X-CMAE-Envelope: MS4xfK4qv7+gra4/No48+I6OHOAAcujcXRS/PfnQikgxcDSrrZP8L+TerLeHy145s/KAceVypRDil5xRxeB1/vzUSby/f7rIDkgSck1YqkCDCzkaIarhqx9/
 K83x6mgacZAZD6UJ1bRwJrj81dGWHJUI0IkmTVOcDAWJaAdwa4IovLzKJ8pIkAKC+CcRdXZhJBSqQ/pR5IENNVwCjTpvCD7WHgtTG7GXVpBjMk6vO0XSBbZm
 HajaaQ/TvJX2ofptE1UlCCyI/givaCNAV38SrV12FEYyq1557j6shxIus4dIuXaCCpPjVDVE/AheK9Dmk0GT5zDEYEFyLvppEAweRIE04oo=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--115511-10179-1660593697=:1956
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 15 Aug 2022, John Ogness wrote:
> On 2022-08-15, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>> On (22/08/10 14:25), Marc Aurèle La France wrote:

>>> Make the kernel log's buffer size available to userland so it can be
>>> used with `dmesg -s`.

> This information is already available via:

>    klogctl(SYSLOG_ACTION_SIZE_BUFFER, NULL, 0)

> And dmesg already uses this with "dmesg -S".

Thanks for the much more helpful reply.

Have a great day.

Marc.
--115511-10179-1660593697=:1956--
