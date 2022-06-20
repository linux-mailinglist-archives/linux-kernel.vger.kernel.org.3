Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45A6551204
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbiFTIBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239686AbiFTIBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:01:01 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D57F10FFC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:00:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s21so5391783lfs.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fJzcCU1G3TC1ezW7ZtUyaMBVLJGZdo22RmweX9xIqCc=;
        b=kO+T5tzhk57vOnvcqmFVHf42OpAwIKflbMrGT2ZOJH75C7RRmZise7wtdOwslPagsw
         GVyM57FdidqlnCctFfSMajuFE+y/T8wPdja+vlKKW5jtzKPkLL1chH7PZTz1uMgDAGYv
         yW08D6E36BaMEy4qxMmGOlMhWXCKE6ABINsB7ZeVctcoxT9urjrP/8G5AkfiMhn/NU2U
         0iMl9FIRLxQHLcYCrMh6HfQmQhMjqfXy6F+LJ2VJrumw1oWQsbhuJDlt4xPpBLmeIYS9
         NIpr8+87UXhzAcfYHjwkhdIAlix4iaxzKOdTk0hDKmI1u664403DwN23/kzuEKjRLJ6c
         3JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fJzcCU1G3TC1ezW7ZtUyaMBVLJGZdo22RmweX9xIqCc=;
        b=FQkt+ts1Mwrep3j6gGLI4XgkqYEXka+ECjPD3YPWvmycolDJMTRfcsZWdiCa8PIcPS
         WBeE1mLCMizNAfqKz0DCVBDCEY9UMs0z1z+zzbhZNWGUM6PIO7jFsi7WcyXdeUOR6PQp
         C0lSJn82pNkmVx5FPTaPTuK0o5TKxICqYhylUgZWmxe16SuELnKataCLyadoXc6gphAj
         RSVB8LL+GO+iuyTIdEMX7BP62t4hXYCpIa5qyF7dITek4c3BlMoVb9j9hR+5lZ+TdJbp
         6ssptBKyuBFCtAAXzR/jbLxYuvbjTRET+EZtmH6eNuKi/O+XYx4bmT63qYLMcpuWBj/u
         rSUw==
X-Gm-Message-State: AJIora/27vR8cOLEO1W02xoicGLPjXdBLwQ+f0w/i5iuur5uFd/F/fEC
        ceov544+31lSxk/zIHILs6lqxQ==
X-Google-Smtp-Source: AGRyM1uwm7SkDhskBu6uhtza2FodsrwKa+qGYebVkb7kb0YQe2Z/jFepWNgu/hdkbwt3x1cS2R6IWA==
X-Received: by 2002:a05:6512:3e13:b0:47f:3ef1:88c1 with SMTP id i19-20020a0565123e1300b0047f3ef188c1mr13058487lfv.31.1655712057479;
        Mon, 20 Jun 2022 01:00:57 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id q6-20020a056512210600b0047255d21153sm943390lfr.130.2022.06.20.01.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:00:57 -0700 (PDT)
Message-ID: <9bc8de5f-fd80-57fe-0169-0ec942638299@openvz.org>
Date:   Mon, 20 Jun 2022 11:00:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: "Bad pagetable: 000c" crashes and errata "Not-Present Page Faults
 May Set the RSVD Flag in the Error Code"
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     kernel@openvz.org, Konstantin Khorenko <khorenko@virtuozzo.com>,
        steve.sipes@comandsolutions.com, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <aae9c7c6-989c-0261-470a-252537493b53@openvz.org>
 <04db74ce-4e43-1edb-34e6-ca162f483680@intel.com>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <04db74ce-4e43-1edb-34e6-ca162f483680@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 10:18, Dave Hansen wrote:
> On 6/19/22 22:29, Vasily Averin wrote:
>> Some (old?) Intel CPU's have errata:
>> "Not-Present Page Faults May Set the RSVD Flag in the Error Code
> 
> Do you happen to have a link to the actual erratum document?  It's
> usually a "Specification Update" for some model or another.

For Intel Xeon E5400 used on affected node:
https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-5400-spec-update.pdf
Intel® Xeon® Processor 5400 Series
Specification Update
August 2013
Document Number: 318585-021

page 39
AX74. Not-Present Page Faults May Set the RSVD Flag in the Error Cod

Later I've found similar articles for another processors too.

Thank you,
	Vasily Averin
