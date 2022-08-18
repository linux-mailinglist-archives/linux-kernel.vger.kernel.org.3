Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967E5598DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345961AbiHRUZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346041AbiHRUYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:24:42 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE3FFDD;
        Thu, 18 Aug 2022 13:24:21 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id bf22so2735559pjb.4;
        Thu, 18 Aug 2022 13:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ssxLyq6CQONWY5UbiVJyKpXAkCeoKBNrNN5KQhifA1w=;
        b=iVwRMc1ONHYg2J9nvigSbnx1W+sGcIKstiDSUGrR9mZZGasCOk/dXmxA/9N0mSqElj
         bSXR+KDZ2jfQw2CXQvnFI13gHKOf4PPZHOcEF94o0Gbolay8Ky/SjAmm/CrR2JMUrIk/
         4mUBcFiZP3yXswyNtyr3jguzJppbgqDOE9LVZS36sYmYdNgW9sQpCu5OY9KopKANiwxx
         zSI3wr1HkSXHaCa57g36fYym3hG2gsXNyFd1kQ+kI2hvW/vgx8qpXFC6ETmsZ+1QXAA1
         x59mo8Q6JeMv1aIn8NBgopSK2YTuItmuBFaP18i8RaGEpaQlzyK2X0wADUmCCCis613X
         VBSQ==
X-Gm-Message-State: ACgBeo2m2AQlOkdYcpA/HXtWftQ6X1vUR46Epq9/BRQFyAkqwTcGb4oY
        QMXrIkSdIAi6nXunM0z4W9Q=
X-Google-Smtp-Source: AA6agR6Q1voL2+qaPsOyAGhYxJXcAc+9epgnvg8RdcvtosJC1NL/im0v8Bq8ckmT585++ccQdQH8Yw==
X-Received: by 2002:a17:90b:4a0a:b0:1f4:e4fc:91d3 with SMTP id kk10-20020a17090b4a0a00b001f4e4fc91d3mr10309941pjb.67.1660854261010;
        Thu, 18 Aug 2022 13:24:21 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id h12-20020aa79f4c000000b0052e57ed8cdasm2049984pfr.55.2022.08.18.13.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 13:24:20 -0700 (PDT)
Message-ID: <02e92b29-9fcd-b52f-3ddb-e5e20e6db604@acm.org>
Date:   Thu, 18 Aug 2022 13:24:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH v2 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Can Guo <quic_cang@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        jongmin jeong <jjmin.jeong@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1660213984-37793-1-git-send-email-quic_cang@quicinc.com>
 <1660213984-37793-2-git-send-email-quic_cang@quicinc.com>
 <20220812091012.GB4956@thinkpad>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220812091012.GB4956@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 02:10, Manivannan Sadhasivam wrote:
> On Thu, Aug 11, 2022 at 03:33:03AM -0700, Can Guo wrote:
>> +static unsigned int dev_cmd_queue = 1;
>> +static unsigned int read_queues;
> 
> Where is this initialized?

The Linux kernel coding style does not allow to explicitly initialize 
static variables to zero.

>> +
>> +static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
>> +{
>> +	unsigned int n;
>> +	int ret;
>> +
>> +	ret = kstrtouint(val, 10, &n);
>> +	if (ret)
>> +		return ret;
>> +	if (n > num_possible_cpus())
>> +		return -EINVAL;
>> +	return param_set_uint(val, kp);
>> +}
>> +
>> +static const struct kernel_param_ops rw_queue_count_ops = {
>> +	.set = rw_queue_count_set,
>> +	.get = param_get_uint,
>> +};
>> +
>> +static unsigned int rw_queues = 8;
>> +module_param_cb(rw_queues, &rw_queue_count_ops, &rw_queues, 0644);
>> +MODULE_PARM_DESC(rw_queues, "Number of queues used for rw. Default value is 8");
>> +
> 
> Using module params is not encouraged these days. So please switch to Kconfig.

Hmm ... I think using CONFIG_* variables is worse than using module 
parameters since modifying CONFIG_* variables requires rebuilding the 
kernel.

>> +struct cq_entry {
>> +	/* DW 0-1 */
>> +	__le32 command_desc_base_addr_lo;
>> +	__le32 command_desc_base_addr_hi;
>> +
>> +	/* DW 2 */
>> +	__le16  response_upiu_length;
>> +	__le16  response_upiu_offset;
>> +
>> +	/* DW 3 */
>> +	__le16  prd_table_length;
>> +	__le16  prd_table_offset;
>> +
>> +	/* DW 4 */
>> +	__le32 status;
>> +
>> +	/* DW 5-7 */
>> +	u32 reserved[3];
>> +};
> 
> packed?

Using __packed if it is not necessary is wrong since it makes code slower.

Thanks,

Bart.
