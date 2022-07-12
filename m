Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE413571858
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiGLLOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiGLLNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEAC9B23EF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657624388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slHwrhsSOL07LWoU4O4a8Klr2iEqMdZCY2kE3rkbshs=;
        b=BFlszsJzRGWuN3pGa6VOfNTYJE9HzIMiNi97kK5Gtp+1SUCUUDRkpNzo9ffHBjy0szr9Lx
        3WCKF1+48BLReFSuU2wTaK82mS15dz0DJQXSWYFJu2wL+UPoBrROzmoL48Gln8kbhVXdgM
        91LoyBZxNuf+7rPnzwS+mUomWi16rgY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-uG-03dNhMqGjEw7ob6q6rw-1; Tue, 12 Jul 2022 07:13:07 -0400
X-MC-Unique: uG-03dNhMqGjEw7ob6q6rw-1
Received: by mail-wm1-f71.google.com with SMTP id g22-20020a7bc4d6000000b003a2e0951432so3631191wmk.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=slHwrhsSOL07LWoU4O4a8Klr2iEqMdZCY2kE3rkbshs=;
        b=K4yd90EsiRgU2jg5BumzQlxon2FYzHHtn7Hy+JPl/1wdqK8Lyb/l1osVZfBOSrvA0d
         +k4RzKMT6k+XChS6od9RN1t06ksOhnEM8ZPlhN9CLMW30UK3Q2mj6A02wcJrUdF7P5qO
         2aj0BORROT4j/YNvV6abawMnXT1EXuyiQuwUTaiNqZ7sjtg+1hbAVgo0ruxYYduKQadM
         Di0U/X61I4+7K3Wm+dhEhqHlVsPvWUqMDwP48plU19AOhlp1Dv8MtdFdzyv5BAuY7RXk
         MeMS7wKO/KhtvbDxB4RuFwMV0k5MPvH+uC51l48J5c5a8OEO5mHxz662sa0sLqs5b7RA
         5bIA==
X-Gm-Message-State: AJIora855JI3//6hn4MfHcWqu3l4Utx1cMornVTTC8fiTMdJp1QDWf+c
        OqOVSdnkNZYrSDzCK1wuU7tDsnq7SRM4DdtBgQffmInnlJT/0ayyoC83+72KI9MDURZS8RWbN7P
        yHQOcpwNlNlHjr04p3NOqFr6H
X-Received: by 2002:a05:6000:154a:b0:21d:b74d:3561 with SMTP id 10-20020a056000154a00b0021db74d3561mr488335wry.584.1657624385899;
        Tue, 12 Jul 2022 04:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t8ZhXvsJEW8VYsrpIys/4zoUZ19sQAWjNoeBLraKcWG+eh+OaPJTWsHlZQCLCOGeak6REuKg==
X-Received: by 2002:a05:6000:154a:b0:21d:b74d:3561 with SMTP id 10-20020a056000154a00b0021db74d3561mr488316wry.584.1657624385694;
        Tue, 12 Jul 2022 04:13:05 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d4a90000000b0021d6ac977fasm8094998wrq.69.2022.07.12.04.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:13:04 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        akpm@linux-foundation.org
Subject: Re: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
In-Reply-To: <Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
References: <20220630223258.4144112-1-vschneid@redhat.com>
 <Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
Date:   Tue, 12 Jul 2022 12:13:03 +0100
Message-ID: <xhsmh35f68tz4.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/22 10:47, Baoquan He wrote:
> Hi,
>
> On 06/30/22 at 11:32pm, Valentin Schneider wrote:
>> Hi folks,
>>
>> Here's ~v3~ v4 where we now completely get rid of kexec_mutex.
>>
>> o Patch 1 makes sure all kexec_mutex acquisitions are trylocks. This prevents
>>   having to add any while(atomic_cmpxchg()) loops which I'd really hate to see
>>   here. If that can't be done then I think we're better off with the combined
>>   mutex+atomic var approach.
>> o Patch 2 does the mutex -> atomic var switch.
>
> This series looks good, has it been taken into any tree?
>

I don't think so, briefly poked around git and haven't seen it anywhere.

> Thanks
> Baoquan

