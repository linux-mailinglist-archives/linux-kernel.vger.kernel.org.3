Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1662357AA3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbiGSXHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240538AbiGSXHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:07:10 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E5861D91;
        Tue, 19 Jul 2022 16:07:09 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so435205pjf.2;
        Tue, 19 Jul 2022 16:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Tw23vDNo/n+pN2EHeNiGsK/YDkkAImg4vz2iP2eaGM=;
        b=7VE5lneYyBfeMoHUigqV4hdK3mJUjPsBpaOZ2O09H2v8l0kba0r49OY67nmHPrZKqv
         1eMUh09SCIyK6nfXtOJxqjif8Yx1WTkfTaxThYkiGaNLc+a/kkXvUcIgWSVwgiu+4kqh
         g0AwXl5PA4qvmNzmDF6d4nSzc77L0YWD+YVz9hcwpLyzz3lqSn4FLea7tbQL3ooJdygZ
         kfUR6ed8mPa6H5wKCg+JwJj4ZropAQvcAL+UvdUuCMX7fUEuFqOj7ALLbOSA1463+GG5
         ssRQoZQXjZT3rtPAurc3nVnlXIuxcbgzbWI4bqN4YOwy4RBvThuswMVrOpDgArHd8SD7
         guVg==
X-Gm-Message-State: AJIora9tg3MI4J/CKJL80fHM+5QJjcAxNJXm1uEE1SrNUg5EWhpt1V5U
        Uw/LDDKtjtRFBtXYJSKBN20=
X-Google-Smtp-Source: AGRyM1vG7yGVeWpxGJlPtp3YHkTJUdzIERYOZYK1v+sjBcXtiq+FJvIg2cJR7cf61v44YD8bPxJUAA==
X-Received: by 2002:a17:902:e848:b0:16c:41d1:19cf with SMTP id t8-20020a170902e84800b0016c41d119cfmr35595037plg.40.1658272028471;
        Tue, 19 Jul 2022 16:07:08 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a7e0:78fc:9269:215b? ([2620:15c:211:201:a7e0:78fc:9269:215b])
        by smtp.gmail.com with ESMTPSA id t126-20020a628184000000b0050dc7628148sm12100127pfd.34.2022.07.19.16.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 16:07:07 -0700 (PDT)
Message-ID: <574ad23b-45c9-1bc3-0a86-c7cb73ea07bf@acm.org>
Date:   Tue, 19 Jul 2022 16:07:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, beanhuo@micron.com, quic_asutoshd@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        linux-scsi@vger.kernel.org, kernel-team@android.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
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

On 7/19/22 00:01, Can Guo wrote:
> Adds MCQ support to UFS driver.

The description of this patch is too short. It should be explained how 
the UFSHCI queues are made visible to the block layer. It should also be 
explained which roles are assigned to queues and how (HCTX_TYPE_*). How 
the MAXQ configuration register is handled should also be explained.

The host lock is obtained in multiple UFSHCI 3.0 code paths. Information 
about the role of the host lock in MCQ code should be provided.

Thanks,

Bart.
