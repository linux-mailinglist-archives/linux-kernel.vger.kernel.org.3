Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9260F57A1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbiGSOjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbiGSOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 298372674
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658241251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q1yQacfB3hLbpLHmQUXt3vJmaATxthgTSKeJu9pPsQE=;
        b=DRX9ueBuMY2oMrMV72HpOJzkzxSKDbqareEPrh05chA1qmqMvpfTQsSoY0dA4aKVB2Dy8q
        cQ3K2U+gkquw9JQp7nDIW7G7fyISoudNFR+iQE7j1rRvALLcquUfNsFAKgBMRezdgEyV/b
        8/rzGuAXQSC1mKp4JOTufQCPmCOD+go=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-pKg275crNuS2U-SShTnPRQ-1; Tue, 19 Jul 2022 10:34:09 -0400
X-MC-Unique: pKg275crNuS2U-SShTnPRQ-1
Received: by mail-wm1-f69.google.com with SMTP id c17-20020a7bc011000000b003a2bfaf8d3dso6888598wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=q1yQacfB3hLbpLHmQUXt3vJmaATxthgTSKeJu9pPsQE=;
        b=d3RErBk8yE+Zvs+iBu5ShdeGwKicQZEUuuncbda9dfHzkbT6hyrkVvnfuu0ddtgQg8
         bhqHch5xYXvRFcLL+oU3WAcExf6lDLE2d3GVWELsv4Z7L6qT0660kigibv34KPKRd2oy
         sZmVFjtERWnyAanF8bN3BiGHj/3DyG6J+/QFj2o5cV3uunqlEMjdVCgLOLo8MplurAPa
         uuyvzt5DLLXWoxvALhFafhQR39jU3dzWVjDwnA0NvO7zORHUi45uYVMU6d3wXUcv6IcM
         EQvPWnTo+fTxgLXQSIJQXnqLSRKD2V1HvsUXpLXbgM0exzt/4ubKTduBeh6HbMErylAI
         UGew==
X-Gm-Message-State: AJIora85iaessHRX8+SbUQ8jNr09fVfwjLHWJL31GXzvsI2qGqmqq8NU
        6U3L5X0ea+Obh7XQHsXsrt9cqm+yF9BgQIcQmYnwJW/t1C7gPl1rp6YQLBJuZwMLRcxIzN+68+/
        OckWHLJ+i3BUl4mWTxi/gEJoO
X-Received: by 2002:a05:6000:1d96:b0:21e:3e47:4558 with SMTP id bk22-20020a0560001d9600b0021e3e474558mr2281810wrb.253.1658241248799;
        Tue, 19 Jul 2022 07:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uTWDSdIJ3vFJzY1HG6rASVk4nIiPxphveENq1YEt5pXz7tSZkFrUKW6JuNJNVSt9b5R30XyA==
X-Received: by 2002:a05:6000:1d96:b0:21e:3e47:4558 with SMTP id bk22-20020a0560001d9600b0021e3e474558mr2281802wrb.253.1658241248652;
        Tue, 19 Jul 2022 07:34:08 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id bd20-20020a05600c1f1400b003a3211112f8sm3443171wmb.46.2022.07.19.07.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:34:08 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/2] cpuhp: Set cpuhp target for boot cpu
In-Reply-To: <20220711211619.112854-3-pauld@redhat.com>
References: <20220711211619.112854-1-pauld@redhat.com>
 <20220711211619.112854-3-pauld@redhat.com>
Date:   Tue, 19 Jul 2022 15:34:06 +0100
Message-ID: <xhsmhilnt6ujl.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/22 17:16, Phil Auld wrote:
> Since the boot cpu does not go through the hotplug process it ends
> up with state == CPUHP_ONLINE but target == CPUHP_OFFLINE.
> Set the target to match in boot_cpu_hotplug_init().
>
> Signed-off-by: Phil Auld <pauld@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

