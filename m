Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665BC4F68E5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239856AbiDFSC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239845AbiDFSCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:02:05 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C38A66CD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:36:14 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so3466418fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cWbJFshnMLCyQMm85xYAkXFkR+kCELC0QqqCbrTJ7cw=;
        b=ZhMxncjdppVUfc3IXaFJ859lygs7+hWzNVM+SD352YReK+prWIAvRnY5grr2PeemsT
         tqw3lSTWWxg1Kvcsxv0fzvImIMbmjd/1mKndS0NmsfCSCv8as2YENjzGSLETESmFFMrF
         D1oSrPQ3Sevvs1Itk2EC77+Ds3h4mKTEpr/rt+O57PmHhfyMz05lyt72+rOoxEFLXOTj
         KVQKZQt4yVEqMl30Ffzfi0u1zf/sVcha5cF2rgyE1EJNIeFJ6uPSE9oE8zTa/E/jkmEa
         Yard5lNyNwz0ZZjrHZedPp46sLBuxTYRuOTNB6KiomYdW5T18wAyerSY5vPy6qnRKHQx
         wTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cWbJFshnMLCyQMm85xYAkXFkR+kCELC0QqqCbrTJ7cw=;
        b=1s+cosTk8ktmWFGd1oUGqhUvlIJbOwNLMc/aPwF273WE+smu/jS2qKQeNKedMllriB
         MknPfooMG79qHE6CbcauProGz2ZXuWJ6wr8A1T7N6jxx+gqe/PpMUo8ajIjg7y1KDMGC
         F/KFZJUFKiF5Yn2UyGVdnmUoyEraA4E2e0c3c3UZNcbHCHLytAsDaZfRK3VJ7JNJPZN6
         aCqNBb6XVFds/iL7SUn5D2UOY0kQi/ZdV4z8msY84+xQF7GPW+gZVlaTpK0IwWyszLr0
         JGcAK6IuYEFisrG39OTFmWv8Cs3yn97QDK0FEYLPHtawkBbPLewkjwZbSeeB/9vqdS3Y
         /NyA==
X-Gm-Message-State: AOAM531IIJaN9kYaULFciyBHbr2/GsB+JdD2qByWsMfLbMySSl9eXz2M
        QsmK2O703bzcLExoo4bKvaGij7rEV0o=
X-Google-Smtp-Source: ABdhPJwg4XTVx1A7TJ65KxKMk82QwrSHyLAOgNU0PQP5e50vXJJhdmEXKlTxAo55dBAd9BuImcCCZQ==
X-Received: by 2002:a05:6871:822:b0:e2:10ff:b84e with SMTP id q34-20020a056871082200b000e210ffb84emr4251863oap.103.1649262973819;
        Wed, 06 Apr 2022 09:36:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n128-20020a4a4086000000b0032118eda64bsm6300635ooa.38.2022.04.06.09.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 09:36:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <59941012-6eb6-91f3-ac79-cca759fa53d7@roeck-us.net>
Date:   Wed, 6 Apr 2022 09:36:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Bluetooth: hci_qca: Use del_timer_sync() before freeing
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220404182236.1caa174e@rorschach.local.home>
 <97d1cc84-890c-3fcf-2efc-645633cd36b2@gmail.com>
 <20220406153907.GA1994259@roeck-us.net>
 <20220406114654.3c0e17a8@gandalf.local.home>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220406114654.3c0e17a8@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 08:46, Steven Rostedt wrote:
> On Wed, 6 Apr 2022 08:39:07 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>> ie move this destroy_workqueue() up ?
>>>    
>>
>> What prevents the timer code from queueing work into the destroyed
>> workqueue ?
> 
> So we have a chicken verses egg issue here?
> 

Almost looks like it, unless I am missing something. Maybe some flag
is needed to prevent the timer handling code from queuing into the
destroyed workqueue, or the workqueue handler from updating the timer.

Guenter
