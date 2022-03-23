Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1854E4B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbiCWC7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 22:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiCWC7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:59:00 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E390A70864;
        Tue, 22 Mar 2022 19:57:31 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id c23so353617plo.0;
        Tue, 22 Mar 2022 19:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XdtGK4rmRWu9kbcb/j+mRwJrjPioe83qUnPzzHWXTQM=;
        b=hOTbXYQ+hdgB6CHQrx27rKZi6dqG0qOP0SsKjCnlviwBYqkzVtwjHrJUI8lEY9jbPy
         hiHz85/m6mCcqJXMueUCky/komPNQpbogMpVzIOVCcphzVu7DArn7dyKZwc9SW3q7qJ5
         KnNS7gV52dpXSku0zR37maTuWsXDb63A7zBP1KYTK0LfOSIiIqMHu9OAzNTLLw71LIjn
         3JmWjv/jB3DccaslWTEBWAcrNJ9FpIec+O4Kzw7Mzcgqk5KBWGtNqRsVEq0Q0KA1jW/f
         OMkly43Ym+NFMrsH6fsUeG38CqdaP+ttwFvKc5C88a/0WzTYGzx9RTypLwPtaOLDI3y3
         tMFg==
X-Gm-Message-State: AOAM532lUsqSufaMXc72MMCAiNhG1d3DfohV4ClaM71tISFXr474mnNA
        8t8K4W29fLHUgM/wLYO1lVWAgQWiVJQ=
X-Google-Smtp-Source: ABdhPJwSFEIHiVSTOmzTD2GpstiC4F+wLHyntg8/TEzIPpoV27kY2teF1rJv/n+nM+gczQuBLAtydA==
X-Received: by 2002:a17:902:8605:b0:151:b6a2:8a1 with SMTP id f5-20020a170902860500b00151b6a208a1mr21517901plo.64.1648004251166;
        Tue, 22 Mar 2022 19:57:31 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a005000b001c7511dc31esm4019995pjb.41.2022.03.22.19.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 19:57:30 -0700 (PDT)
Message-ID: <e74776f0-505b-8b4f-effd-519bce9bdc79@acm.org>
Date:   Tue, 22 Mar 2022 19:57:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/11] blk-mq: Add blk_mq_init_queue_ops()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hch@lst.de, ming.lei@redhat.com,
        hare@suse.de
Cc:     chenxiang66@hisilicon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com, beanhuo@micron.com
References: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
 <1647945585-197349-2-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1647945585-197349-2-git-send-email-john.garry@huawei.com>
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

On 3/22/22 03:39, John Garry wrote:
> Add an API to allocate a request queue which accepts a custom set of
> blk_mq_ops for that request queue.
> 
> The reason which we may want custom ops is for queuing requests which we
> don't want to go through the normal queuing path.

Custom ops shouldn't be required for this. See e.g. how tmf_queue
is used in the UFS driver for an example of a queue implementation
with custom operations and that does not require changes of the block
layer core.

Thanks,

Bart.
