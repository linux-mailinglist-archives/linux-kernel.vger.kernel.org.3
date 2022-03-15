Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD6D4D9704
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346268AbiCOJDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346362AbiCOJDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E3C74D9FC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647334952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yp3qo6eiC6KxlqVnevYb4PouXujwadZ3BmfsYINZZ0E=;
        b=XZZKKwvFLBXz0OHvzJLptbCUVTAEWBu1RqUxM68xa7C14EqsenTsbG9TTiuLoA5ijjDIp4
        Vq6Wg4seLleXMJaxuJE3N/ttFV+guNN++tQUXCB+/tbGpRY+l+wu4VKcYpHoS1rQ69fOBU
        FsUQe9E5yL+XVrHBkr0gStFU3GdF/xU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-0PtwoCUWP_K0_kGAiMfPvw-1; Tue, 15 Mar 2022 05:02:30 -0400
X-MC-Unique: 0PtwoCUWP_K0_kGAiMfPvw-1
Received: by mail-qk1-f197.google.com with SMTP id l68-20020a378947000000b0067df0c430d8so2822448qkd.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yp3qo6eiC6KxlqVnevYb4PouXujwadZ3BmfsYINZZ0E=;
        b=8EVi8FqMTGuVPCQiHJI0L1NEIpg/z/ZpG+IwF++LrJyh0+Dx2UGyk1ow/15hontl46
         AfgO4E5d915ksX3PD6fWVDxiALUou8s16yXzjWhRo5uVz4viJaRMuV17Nd7sdHX7paPO
         /r/HHBI+ZJwx7ZWvDID+aKbbmAfxtDsi9oPpmJEYAFspKRsHZ/Y52GpjvS985fLVt/4h
         OLlSFIT48mK/1wGfc13M6oacz1iJd4bjpZNuaRUvLina6sljHGMrHfLoqJ8RuPmNtzEH
         SmG3iwE0+287Uc5JDMO4JmB1ER51m7ASnuYNHpV7FaAcJzgPshLLn64lzM7MQngFbZwb
         9dcA==
X-Gm-Message-State: AOAM533B3lElH5QbXolhtM0H5I2C5y3dmNIg1SlsqrqSgxYTtlwSMvh7
        PfKTAkVFN/p4jA5R08cVKGJ8luyRHLBfHPijYSU61DIAVRlyVfUs1dbVxASujCxM6uvwXcMrN0V
        os+08awRZw4XrR5osdcBEXgvY
X-Received: by 2002:a05:622a:174f:b0:2e0:5a1f:9acf with SMTP id l15-20020a05622a174f00b002e05a1f9acfmr21617358qtk.304.1647334950426;
        Tue, 15 Mar 2022 02:02:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6IjTjiGxTtEsWKanwVTySC3RCciJFu1NEsC5/Zfj6KgnMFM46immWIoqflVXJmlw7RwwunA==
X-Received: by 2002:a05:622a:174f:b0:2e0:5a1f:9acf with SMTP id l15-20020a05622a174f00b002e05a1f9acfmr21617341qtk.304.1647334950169;
        Tue, 15 Mar 2022 02:02:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id g5-20020ac87f45000000b002e125ef0ba3sm12395512qtk.82.2022.03.15.02.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 02:02:29 -0700 (PDT)
Message-ID: <f8f41d9568b9fb7e2fb9cc755ff2e87db9c35f1f.camel@redhat.com>
Subject: Re: [PATCH v4] net: ksz884x: optimize netdev_open flow and remove
 static variable
From:   Paolo Abeni <pabeni@redhat.com>
To:     wudaemon <wudaemon@163.com>, davem@davemloft.net, kuba@kernel.org,
        m.grzeschik@pengutronix.de, chenhao288@hisilicon.com, arnd@arndb.de
Cc:     shenyang39@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 15 Mar 2022 10:02:26 +0100
In-Reply-To: <20220313032748.3642-1-wudaemon@163.com>
References: <20220313032748.3642-1-wudaemon@163.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 2022-03-13 at 03:27 +0000, wudaemon wrote:
> remove the static next_jiffies variable, and reinitialize next_jiffies to simplify netdev_open
> 
> Signed-off-by: wudaemon <wudaemon@163.com>

I'm sorry for tha late feedback, but the above looks like a pseudonyms,
which is explicitly not allowed by the process - see
Documentation/process/submitting-patches.rst.

If the above is guess is true, please respin the patch with your actual
name. While at it, please limit the commit message description at 75
chars and specify a target tree in the subj (net-next I guess?)

Thanks!

Paolo

