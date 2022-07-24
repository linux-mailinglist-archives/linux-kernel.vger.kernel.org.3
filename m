Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBB657F2BB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 05:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiGXDOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 23:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXDOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 23:14:39 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E814086;
        Sat, 23 Jul 2022 20:14:37 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id e16so7564574pfm.11;
        Sat, 23 Jul 2022 20:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rmJi6Fl+KT5nu1fX7BF7IXYSHdVcIZYFdsTgQ9Roz7U=;
        b=OfTOqt7dj+o4jEmBH18B4f6/fWC74qQwraQ6DskQgm/myRdHGBH1gt6v1JZCPdMSAm
         S9BdkUA448RHmYx4ziknJElyo1V/CFuayiAwKLb6yUhMVMt0wWv953gkBRpjYeXGvLJW
         TDA9PsDM4DDbXzx9YmKHpW3a2FQqMwm5n4anarIZcIz1Z502LPqQE1xAWs9by21vhLEo
         7WxguARbqowQ+I+DuPRyC3usZMdMm6kRpVGgUWxXM2dj/oa4wFYJIWQeiaN23suzdDBs
         fBwj6xM24k8/J9d8p0PIi6TdjVdkes/UnIg6ke+FQCohL7pajNrVzipSq+BXG686wson
         RWOg==
X-Gm-Message-State: AJIora86EY8v5FqIFsaQjG2s43bsGVgk1gVIlqdR+Up/Otwex8BuiOqW
        mme2FtpKvihgykAmDBT/5cc=
X-Google-Smtp-Source: AGRyM1tkWTILxQSTvQj00KzSJJTzNrATsJlWUBenjaqu25FIdjmXux7aqnyn8rJPspc3gbFGcRsJQg==
X-Received: by 2002:a63:584c:0:b0:41a:d4e2:f6d8 with SMTP id i12-20020a63584c000000b0041ad4e2f6d8mr3419747pgm.576.1658632477267;
        Sat, 23 Jul 2022 20:14:37 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b0016a565f3f34sm6421758plc.168.2022.07.23.20.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 20:14:36 -0700 (PDT)
Message-ID: <6c4efbc1-baa0-178e-15d2-7ed8bbde75da@acm.org>
Date:   Sat, 23 Jul 2022 20:14:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>, Can Guo <quic_cang@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <DM6PR04MB657575D62B7A2136D6AF1654FC939@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB657575D62B7A2136D6AF1654FC939@DM6PR04MB6575.namprd04.prod.outlook.com>
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

On 7/23/22 08:26, Avri Altman wrote:
>> +
>> +               /* sqen|size|cqid */
>> +               ufsmcq_writel(hba, (1 << 31) | qsize | (i << 16),
>> +                             MCQ_CFG_n(REG_SQATTR, i));
> So there is a 1X1 SQ-CQ topology.
> Isn't that should be configurable?

Hi Avri,

I'm in favor of starting with a 1:1 SQ:CQ mapping and only adding 
support for other approaches if there is a very good reason.

Thanks,

Bart.
