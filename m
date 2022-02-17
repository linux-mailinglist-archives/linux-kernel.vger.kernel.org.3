Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B564B9694
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiBQDWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:22:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiBQDWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:22:16 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A821D339
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:22:02 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r76so3823034pgr.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=g+hjPV8y+gvmFmbS5hJB+qk4Qt345PDJjXzI0nYM+NU=;
        b=H9RYpiO37hzKEZp+K0Mnr6RcJpra5z0HqnWyW7SbO+8+VQyGlDFDEX7Kqv5pRzAQCU
         NGVWtBybvZu5wibJcgjTx5Ixc20rXaBtf82T/8dcK9kkIG9Oy6o+7E2WXnm/VAhOiYKl
         ra5N6HSnEKbhBAazjGdyxYBYVMrcEaaRE3S7C71Yex0DVDFvcNbJZd6ZU+7Nq/nMcpYF
         hqvA6fyGAAftgnwxvQaKTUmgGHtOl+2NabIaIGwsw8smIBXUV8x2WKhS3H0E5WmzCGdJ
         qzAlDAFbKTpuCRI785KhgGCuXOtNH7HG1jK9dpvEK5GizrrqKetgWdK1Y4O9bgJYg7L8
         J/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g+hjPV8y+gvmFmbS5hJB+qk4Qt345PDJjXzI0nYM+NU=;
        b=J4pErcQPNgI3GwjZW8O3wVWmGvM8HOgygdtwt0ubsmyExaAOGVfi1UxVO5gKLwKVsT
         fFBxAGvnkguc7e/4s9xvTzEiAoZ5JZcIGWbHGF+lgaShEcMBTk8wtMliqsQ5rqD+FAby
         6Qp/mGyyWdV6fMPb4I5JsqgIfmG0ENgn5S8OeDXi52etwLGNUqWgcU+MZrdUIdPeEW6D
         5Dw0fpkvtVtujhZINW/V+SkKL8vpzy+M3B3MukArScn8tqMA6enVKGZ77uMDITjB83Xn
         IZlCKJ7KAo9n1pY1gCOu2OqbnT2RIx2yjBc5sCOZNy+JgVkh7XPFscTM94AtMbVgDkop
         Prkg==
X-Gm-Message-State: AOAM531f1RRrWpwwBA7TvUwECPhD4ZINJJ09OqGdauGXsBueFF7QfLZC
        kvpbA//91i9/njCPmSGIQ+wnHw==
X-Google-Smtp-Source: ABdhPJzkmwKfdjmKJLbrWe6DFUVbC2Ik6tDlVNlySsNCa9sNZvhIADpp3zHJ2PpIl507iVKQoVierw==
X-Received: by 2002:a63:5b57:0:b0:370:277b:55c0 with SMTP id l23-20020a635b57000000b00370277b55c0mr891615pgm.148.1645068121819;
        Wed, 16 Feb 2022 19:22:01 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a17sm4228478pfv.23.2022.02.16.19.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 19:22:01 -0800 (PST)
Message-ID: <f7936d00-a495-64b9-9497-7eb515d7c15b@kernel.dk>
Date:   Wed, 16 Feb 2022 20:21:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC V4 0/6] blk: make blk-rq-qos policies pluggable and modular
Content-Language: en-US
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220217031349.98561-1-jianchao.wan9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 8:13 PM, Wang Jianchao (Kuaishou) wrote:
> Hi Jens
> 
> blk-rq-qos is a standalone framework out of io-sched and can be used to
> control or observe the IO progress in block-layer with hooks. blk-rq-qos
> is a great design but right now, it is totally fixed and built-in and shut
> out peoples who want to use it with external module.
> 
> This patchset attempts to make blk-rq-qos framework pluggable and modular.
> Then we can update the blk-rq-qos policy module w/o stopping the IO workload.
> And it is more convenient to introduce new policy on old machines w/o udgrade
> kernel. And we can close all of the blk-rq-qos policy if we needn't any of
> them. At the moment, the request_queue.rqos list is empty, we needn't to
> waste cpu cyles on them.

I like this patchset, would be a lot more convenient and helps
efficiency.

What kind of testing have you done on it?

-- 
Jens Axboe

