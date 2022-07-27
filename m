Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A3C583283
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiG0Szw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiG0Szd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:55:33 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A38053A;
        Wed, 27 Jul 2022 10:54:52 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 72so16554161pge.0;
        Wed, 27 Jul 2022 10:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iM28l70GATLFve15qcYA6iaGMWXkiPg+C+0XFnQgM0I=;
        b=prLxW6GwxBQPFpqB2seyxhJ/L/kOnXnZUY2V4bx5IYuf9WxwQPhgucfaaXVa8dV2kN
         73d1B9Gk8hPgKAwE2FqkMr/JSU221ZO53ra5R6h/j3iPvicM0VFXbn7pJnvEN0qfYqK0
         rLxdjQ555zkZ67He8gSkmSYjPJ4F5bztMx3A4rbOwHw7JfAV+Q+JrzfgdLNIxSMzctvh
         ml6gkSWm+YGa7QZH1uGz0WN/efqXrpy8A82PhiSNdSFxwCZMFt4Z99QSHDVg6YFsa5dD
         XuqJIJ9csjU7/vr8NOnPvFU8Nl7dzKlejGTEmaFOqFlw9/b6W3awDVSHlF5XrKtqVGOV
         SUtg==
X-Gm-Message-State: AJIora8vbluhEu293EAlP2hfHMoPbQCMTz/86Jsa6LXwzMQjS/SUEj7v
        gflXL5ANsrmtHv/bQ5U+VgU=
X-Google-Smtp-Source: AGRyM1syk/n8dXBSw+6bXNt1/MGXukbIrHHFSAc89gH3H3WBNC4VJg/AlmxyERIjInCDCpkaKnOmIQ==
X-Received: by 2002:a05:6a00:16ca:b0:52b:cc59:9488 with SMTP id l10-20020a056a0016ca00b0052bcc599488mr22849005pfc.0.1658944491439;
        Wed, 27 Jul 2022 10:54:51 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a84e:2ec1:1b57:b033? ([2620:15c:211:201:a84e:2ec1:1b57:b033])
        by smtp.gmail.com with ESMTPSA id c3-20020a170903234300b0016be5f24aaesm11961037plh.163.2022.07.27.10.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 10:54:50 -0700 (PDT)
Message-ID: <3be80a61-3002-eba1-53e2-928ffa740902@acm.org>
Date:   Wed, 27 Jul 2022 10:54:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scsi: ufs: introduce dev_cmd_notify callback
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        Gyunghoon Kwon <goodjob.kwon@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc:     "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20220727051046epcas2p15481688ac3b7917bed8d06ebfb0a4184@epcas2p1.samsung.com>
 <20220727050954.118743-1-goodjob.kwon@samsung.com>
 <DM6PR04MB65752988E971F9953913C38DFC979@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB65752988E971F9953913C38DFC979@DM6PR04MB6575.namprd04.prod.outlook.com>
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

On 7/26/22 22:16, Avri Altman wrote:
>> Some UFS host controller may need to synchronize dev command among UFS
>> host controllers.
>
> You need to include at least one implementation of this vop,
> Otherwise, its just a piece of dead code.

+1
