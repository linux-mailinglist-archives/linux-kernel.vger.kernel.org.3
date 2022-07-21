Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E390857D318
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiGUSPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiGUSPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:15:00 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5AC8C58E;
        Thu, 21 Jul 2022 11:14:59 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d10so2456576pfd.9;
        Thu, 21 Jul 2022 11:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t3a8s17J19DbJZAUwkumZS1vpnqeVghowkkPMiLPGl8=;
        b=n4Epe+ndhM9BD4W3YsfCiPgWAw1lS61FbcQ4eNegadtPtwKQuEwCtJBHJcP4NqLjrf
         0NNl+7YDRmrUULlkelmZ2ecdaDMrxB47uiQ1yBfnqr4u0j7J/K5frStnTBx+kc6+QADq
         HFhKc8g9SU088WuulQ3ZIFXbDtXNmUEViYJW85/d1M4vrO2QXswRSI/4gagkDl40Sqv0
         V3kpadn1zMzpDnCM02Cq0cscnkbxdbHCnTspuA/+CD6jPfXD8fKJPe7rmtFovqjDhq2u
         yw/1p38Mjkmh4Tgz+nhDHkxB1wUU1JYaXaSpyOjo7o4Ajhm51YFodz3j8y74BO4+uTq4
         O2IQ==
X-Gm-Message-State: AJIora/kZGNCjHe1BmLoa3+yS5ogrAMxbOF4uLIyMXItQTWXqnjusQXF
        gCaHXnBpG4hmsL+o9ipJg80=
X-Google-Smtp-Source: AGRyM1sRufsbNz9N1MENNxYq2sfVjIQRGLCE85k8jYnCBE1ZO6Q1W3ydGW+UEb3mjg+5C0yG+ns5og==
X-Received: by 2002:a05:6a00:cd5:b0:52b:1744:af86 with SMTP id b21-20020a056a000cd500b0052b1744af86mr41811651pfv.19.1658427298804;
        Thu, 21 Jul 2022 11:14:58 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8bc4:1f9a:e474:497? ([2620:15c:211:201:8bc4:1f9a:e474:497])
        by smtp.gmail.com with ESMTPSA id w2-20020a628202000000b0052b6ed5ca40sm2087258pfd.192.2022.07.21.11.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 11:14:57 -0700 (PDT)
Message-ID: <54e20a27-a10b-b77a-e950-1d3398e2e907@acm.org>
Date:   Thu, 21 Jul 2022 11:14:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] scsi: sd: Rework asynchronous resume support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>, ericspero@icloud.com,
        jason600.groome@gmail.com,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220630195703.10155-1-bvanassche@acm.org>
 <20220630195703.10155-3-bvanassche@acm.org>
 <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
 <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org>
 <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
 <CAMuHMdWtxBj8ug7AHTqentF8UD4jpO2sgoWWcQCOvEKLJtdq8A@mail.gmail.com>
 <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org>
 <CAMuHMdVQ2K2v8jpsFfOMk99DG_sBB4_ioiQRroC7K_Ov1wvp9w@mail.gmail.com>
 <6f70e742-9d8a-f389-0482-0ba9696bf445@acm.org>
 <CAMuHMdVc+ATGV-=R3uV6RyF0-mZiuKv7HpmogRBgqGVyO-MKWg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAMuHMdVc+ATGV-=R3uV6RyF0-mZiuKv7HpmogRBgqGVyO-MKWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/22 01:07, Geert Uytterhoeven wrote:
> On Wed, Jul 20, 2022 at 8:04 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> That's surprising. Is there anything unusual about the test setup that I
>> should know, e.g. very small number of CPU cores or a very small queue
>> depth of the SATA device? How about adding pr_info() statements at the
>> start and end of the following functions and also before the return
>> statements in these functions to determine where execution of the START
>> command hangs?
>> * sd_start_done().
>> * sd_start_done_work().
> 
> None of these functions seem to be called at all?
That's weird. This means that either sd_submit_start() hangs or that the 
execution of the START command never finishes. The latter is unlikely 
since the SCSI error handler is assumed to abort commands that hang. It 
would also be weird if sd_submit_start() would hang before the START 
command is submitted since the code flow for submitting the START 
command is very similar to the code flow for submitting the START 
command without patch "scsi: sd: Rework asynchronous resume support" 
(calling scsi_execute()).

What is also weird is that there are at least two SATA setups on which 
this code works fine, including my Qemu setup.

Although it is possible to enable tracing at boot time, adding the 
following parameters to the kernel command line would generate too much 
logging data:

tp_printk 
trace_event=block_rq_complete,block_rq_error,block_rq_insert,block_rq_issue,block_rq_merge,block_rq_remap,block_rq_requeue,scsi_dispatch_cmd_done,scsi_dispatch_cmd_start,scsi_eh_wakeup,scsi_dispatch_cmd_error,scsi_dispatch_cmd_timeout 
scsi_mod.scsi_logging_level=32256

I'm not sure what the best way is to proceed since I cannot reproduce 
this issue.

Bart.
