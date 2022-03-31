Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46304EE2B9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbiCaUhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbiCaUha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:37:30 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFF8FABC1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:35:39 -0700 (PDT)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id a1W5n3SZZ9eePa1W5nafzK; Thu, 31 Mar 2022 22:35:38 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 31 Mar 2022 22:35:38 +0200
X-ME-IP: 90.126.236.122
Message-ID: <5a5fec66-f8af-7e6e-5afe-97e4eb21c51a@wanadoo.fr>
Date:   Thu, 31 Mar 2022 22:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] binderfs: Fix the maximum minor value in
 binderfs_binder_device_create() and binderfs_binder_ctl_create()
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Todd Kjos <tkjos@google.com>
References: <ba880255b91b4682c21c62ae0bc5673e34a119aa.1648379891.git.christophe.jaillet@wanadoo.fr>
 <20220329112011.j4xf2qjktfqokkyn@wittgenstein>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220329112011.j4xf2qjktfqokkyn@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/03/2022 à 13:20, Christian Brauner a écrit :
> On Sun, Mar 27, 2022 at 01:18:17PM +0200, Christophe JAILLET wrote:
>> ida_alloc_max(..., max, ...) returns values from 0 to max, inclusive.
>>
>> So, BINDERFS_MAX_MINOR is a valid value for 'minor'.
>>
>> BINDERFS_MAX_MINOR is '1U << MINORBITS' and we have:
>> 	#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
>>
>> So, When this value is used in MKDEV() and it will overflow.
>>
>> Fixes: 3ad20fe393b3 ("binder: implement binderfs")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This patch is completely speculative.
>>
>> The 'BINDERFS_MAX_MINOR_CAPPED - 1' is here only for symmetry with the
>> BINDERFS_MAX_MINOR case. I'm not sure at all that is is needed and, more
>> importantly, that it is correct.
> 
> Hm, since we're "removing" one alloctable device for the initial ipc
> namespace, I think we need the -1 for the capped value.
> 
> Though I wonder if the simpler fix wouldn't just be to:
> 
> #define BINDERFS_MAX_MINOR MINORMASK
> 
> since include/linux/kdev_t.h has:
> 
> #define MINORBITS	20
> #define MINORMASK	((1U << MINORBITS) - 1)
> 

Hi,
I mostly agree with you, but I don't have a strong opinion on the other 
uses of BINDERFS_MAX_MINOR.

The ones related to 'max' values looks good to me, but I don't know the 
implication for the one used in binderfs_make_inode() and in 
init_binderfs().

I won't be able to help further here.

CJ
