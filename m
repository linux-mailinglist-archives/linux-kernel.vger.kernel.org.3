Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BF557A647
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbiGSSO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbiGSSOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:14:25 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B99E5C979;
        Tue, 19 Jul 2022 11:14:25 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id l124so14295601pfl.8;
        Tue, 19 Jul 2022 11:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dBr9REex/+6G3QPBUfRPrB9+jJoVwDOy1dYS7GNaZ2k=;
        b=2+/LobL8aWzIbe0njkE633kPyDuCymOvfkzGo2tIVUuXP9Zwaj3NOET8+6moUw9Q+J
         jD8qk3+nzDfk8J54PihSNnRspPYX5nNTsvs3w02zj7JsN/KL4qCgCX+/+fHpC4vHS8J7
         4QzQk+yHgjfNfkVXUDz+wk5KBVIR8xzEPXYcvfOF5P0EnzQQ7uueqK5OLXIsJZ0tqLe1
         3WEMUrzA75g0787neci/LS+xo02N5zWbPJLYhsi9Fz4SjDDkXXRGoLbQhP68J7jEnmA8
         2n0O5Vk8PkyvwDFnWfNCGM1aUBQWhhctOI9oqh+954c1QkbZKLfmMjtjvGpmmeyWZc/Q
         zNWQ==
X-Gm-Message-State: AJIora/8V+CWnYdTnAZRBD8NKMBnLDcGx8unxTl3ih/6W0mDRLBlBkA/
        PaxUUWQb+jqKIx3gvWXgVPM=
X-Google-Smtp-Source: AGRyM1vnyLrr8eeKVZN8VzTx0RHYA8N/h8LzBPbJO83+rL4o9JTcra1eB4OWZclONC0Ou4JrzVWEpw==
X-Received: by 2002:a05:6a00:1504:b0:52a:e3ae:a603 with SMTP id q4-20020a056a00150400b0052ae3aea603mr35153601pfu.48.1658254464396;
        Tue, 19 Jul 2022 11:14:24 -0700 (PDT)
Received: from ?IPV6:2600:1010:b002:e126:5611:6026:69c2:37bc? ([2600:1010:b002:e126:5611:6026:69c2:37bc])
        by smtp.gmail.com with ESMTPSA id o186-20020a62cdc3000000b0050dc7628171sm11866177pfg.75.2022.07.19.11.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 11:14:23 -0700 (PDT)
Message-ID: <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org>
Date:   Tue, 19 Jul 2022 11:14:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] scsi: sd: Rework asynchronous resume support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-scsi@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>, ericspero@icloud.com,
        jason600.groome@gmail.com, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220630195703.10155-1-bvanassche@acm.org>
 <20220630195703.10155-3-bvanassche@acm.org>
 <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
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

On 7/19/22 02:26, Geert Uytterhoeven wrote:
> Thanks for your patch, which is now commit 88f1669019bd62b3 ("scsi: sd:
> Rework asynchronous resume support") in scsi/for-next.
> 
> On the Salvator-XS development board[1] with a SATA hard drive
> connected, accessing the hard drive after resume from s2idle hangs.
> I have bisected this to the aformentioned commit, and reverting this
> commit fixes the issue.
> 
> [1] arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dts

Hi Geert,

Thank you for having reported this. How about creating a bug report on 
https://bugzilla.kernel.org/ and attaching the kernel logs with and 
without this patch? It's probably better to upload the kernel logs 
somewhere rather than to post these on the linux-scsi mailing list.

Thanks,

Bart.
