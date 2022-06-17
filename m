Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE9954EFD8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379850AbiFQDvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 23:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379833AbiFQDu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 23:50:57 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17E4663FF;
        Thu, 16 Jun 2022 20:50:56 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id u2so3146609pfc.2;
        Thu, 16 Jun 2022 20:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q1Tw5gtlbm60jQgJOmSoiCUD1TeB/fsK0N0NTHe/6HI=;
        b=hMiFIuYhYV5Q4OkfRPt36XS+aI4r9sVrFzQwi/ueqcxuS46zD1TqtNy3WoGA9jjqPT
         /YEeRmDffJZlQ3XDwpdTAsI2LEFXI13tvqVcE4DqWyLRZobhC0bOPk7bRvP7EYJrX1no
         AyThKFD3LKezL7vpIZFuQ69qJIjrSI7nO2ov9GSO+ccethw9t9QwyQiC4Mk8TxdeTs4m
         V0TEeRMqPxWyCdRUCLpMTqECBnS/MxyzJHb70YVPQ1wuKSWVuFHuUko0Abr1yTwANoHq
         UFGB5svqWZyLv8M6VhLFiWdMlNJdfxV/Sx3JBIG8CYbXyFVBMoEqmnGzf6+azkt3M0tg
         osIw==
X-Gm-Message-State: AJIora+25ELLLQhO/OKagYeS4TIjXDf2owEiY+6/0DWrJQyIpwwr1BoS
        Z0097UcDIf2mAV1wBsrgBS8THN5HHRI=
X-Google-Smtp-Source: AGRyM1s9OsXBGRQWFItQf69mSxYRhA6/ZQgWKvQqGrgAgMRlNCuNPlWjLWaSNAVKQnerbzJoMZ5UAA==
X-Received: by 2002:a63:5205:0:b0:401:7586:74f6 with SMTP id g5-20020a635205000000b00401758674f6mr7228645pgb.591.1655437855982;
        Thu, 16 Jun 2022 20:50:55 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id a14-20020a63704e000000b00408c592db61sm2588606pgn.71.2022.06.16.20.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 20:50:55 -0700 (PDT)
Message-ID: <2205b7c0-53d5-a485-72e3-12810d8c0a42@acm.org>
Date:   Thu, 16 Jun 2022 20:50:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4] scsi: support packing multi-segment in UNMAP command
Content-Language: en-US
To:     Chao Yu <chao@kernel.org>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org
References: <20220616013617.2284341-1-chao@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220616013617.2284341-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 18:36, Chao Yu wrote:
> As SCSI SBC4 specification section 5.30.2 describes that it can
> support unmapping one or more LBA range in single UNMAP command.
> 
> However, previously we only pack one LBA range in UNMAP command
> by default no matter device gives the block limits that says it
> can support unmapping multiple LBA ranges with a single UNMAP
> command.
> 
> This patch sets max_discard_segments config according to block
> limits of device, and supports unmapping multiple LBA ranges with
> a single UNMAP command.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
