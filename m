Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AB75A1BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbiHYVvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242169AbiHYVuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:50:46 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AA72EE;
        Thu, 25 Aug 2022 14:49:47 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id q9so9955024pgq.6;
        Thu, 25 Aug 2022 14:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xfbE5Vo/QzRDekgWPSBG92uSVviACIBSqkJfH4RN/VA=;
        b=exRV9T6MVRps48LTolWdFdI+FQQqQP6hdZGTqd//LLTDpFChWukm7soU5/Ae6Ej0lV
         QOf/Q8MxIecAmJvwA6OgSJxoM4wmGKNs53hEXp9PbxKZ+ivlyDH8XFITkP5wrqdF0nTr
         HTyHgJ1hfYBIMb6TJuhl/1RyfdalGzQM8q6aq2sJluODb1KEqybaSPOXacN6vOQ9Xb8W
         RaQePALkguFYsLpfITDxtDCMPOJ+mUZU2JwellNpGMo5sFGMWrn5gbT3uGBeFPIlsFrP
         J/ur8HDj+6Ab/AfjbpSnaZ9un8+XnMP5yfd/89AFZhr7STO4JWEKnCcRXeXEiXkEerN7
         TfXA==
X-Gm-Message-State: ACgBeo2EIIBTi+niXcY2H2DvPWL06OxhiiJrSZUnmAfsZE2L5OdWsIhk
        6pC+xzJpewbz6MJsxQcFMkg=
X-Google-Smtp-Source: AA6agR73sSARbZPf4AXnzwJxFf85IRxa5zkDqZRlix4b3E0h6AybGGg3LFAG7lL0NOTwlkG6OZE2SQ==
X-Received: by 2002:a05:6a00:1943:b0:536:2bef:2f93 with SMTP id s3-20020a056a00194300b005362bef2f93mr931782pfk.34.1661464186761;
        Thu, 25 Aug 2022 14:49:46 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id ik19-20020a170902ab1300b0016d9a17c8e0sm52556plb.68.2022.08.25.14.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:49:46 -0700 (PDT)
Message-ID: <d4f7f08a-e55b-c1a3-52b3-210b9f5b0a43@acm.org>
Date:   Thu, 25 Aug 2022 14:49:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 06/13] null_blk: allow zoned devices with non
 power-of-2 zone sizes
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121907eucas1p27664a441113cb557af8fce3ef2800e34@eucas1p2.samsung.com>
 <20220823121859.163903-7-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220823121859.163903-7-p.raghav@samsung.com>
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

On 8/23/22 05:18, Pankaj Raghav wrote:
> Convert the power-of-2(po2) based calculation with zone size to be generic
> in null_zone_no with optimization for po2 zone sizes.
> 
> The nr_zones calculation in null_init_zoned_dev has been replaced with a
> division without special handling for po2 zone sizes as this function is
> called only during the initialization and will not be invoked in the hot
> path.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
