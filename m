Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838214D8B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243483AbiCNRxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiCNRxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99ED513F2C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647280331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PoYm4c24Q3JJh2lpWhFWRFLRzas/0vml62uEAb2M70=;
        b=QTBDcmY+laqqzEB8NMsN7E/TkbVMeP4ZZwkDx5g/m7b+tjyOe9io8N15v3rj4Y8FUPAPLC
        gnMtDcQSpt+Bnt0ZiQrB9AaMesJHzp2L9yFIcciTIYgtdpYcYplJlpLsjMRpy6hkNC9yKP
        oxHdzPan6omJtmVrnrAK4U8jz7Y1b/0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-1EdAwJXiNVG2oqTBldw8_Q-1; Mon, 14 Mar 2022 13:52:10 -0400
X-MC-Unique: 1EdAwJXiNVG2oqTBldw8_Q-1
Received: by mail-wr1-f70.google.com with SMTP id y13-20020adfee0d000000b001f1fa450a3dso4686033wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PoYm4c24Q3JJh2lpWhFWRFLRzas/0vml62uEAb2M70=;
        b=Vmalxmt+DtF6NYe3pav/fucCeOi8RQpJBgv3ljc+Fh8AvSaHilb9h+kRfGS35AVRhC
         9YXjPDB/EApvvTUHeMz8/5IJfa2gUOjCs6ozZw1pYwjEfANOHnDDVoNsNPRwj9y6Gfm3
         7IJbQ9ZBCH8F3ibcjpeCsT6a+yHsZrJzit91s9y1Oj8XW7qpw7bpGEQ8Inr8XARvIgd+
         JIJq/l8dYcoo0lEaQMJcul7grydEx5LL3c7Lon/vCR1ZGt0+SGOrvCiKHGTRwpJYldB/
         jBrx3o84Uly58+FMWAgX3T14FLql7Vw3G+rg2SNZhksKg6QqNqvCUjf+e+B01Btrl2O9
         0TfA==
X-Gm-Message-State: AOAM532pcePrfPUNMoJ9vM5jp7H7DhSxc2CPmX3r+l3EYWSVVaHe4jD+
        xc1JVSj286uRsU4CwRuh8k7lF/QqMmcAzRQPa1tvyZvgzyHMoBoMw93HmQWOgy6EIDQDU6Bz86R
        T6nOu2ntQlObMZkQuEgeLHU4P
X-Received: by 2002:a05:6000:1448:b0:1f0:6620:968f with SMTP id v8-20020a056000144800b001f06620968fmr17876447wrx.714.1647280329106;
        Mon, 14 Mar 2022 10:52:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO7a/vR6ZwBhjanEnZfZRofoAb4xNg0ErWA+say3xs9Cyy4NfYJHlDuNQt8RwO/jauBt0CRw==
X-Received: by 2002:a05:6000:1448:b0:1f0:6620:968f with SMTP id v8-20020a056000144800b001f06620968fmr17876423wrx.714.1647280328797;
        Mon, 14 Mar 2022 10:52:08 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3506:3400:69b5:c807:1d52:ff67])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d4bcd000000b001f0620ecb3csm13678781wrt.40.2022.03.14.10.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 10:52:08 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     feng.tang@intel.com, tglx@linutronix.de
Cc:     andi.kleen@intel.com, bp@alien8.de, dave.hansen@intel.com,
        hpa@zytor.com, len.brown@intel.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
        rui.zhang@intel.com, tim.c.chen@intel.com, x86@kernel.org,
        mtosatti@redhat.com, nsaenzju@redhat.com, frederic@kernel.org
Subject: Re: [PATCH v3 1/2] x86/tsc: add a timer to make sure tsc_adjust is always checked
Date:   Mon, 14 Mar 2022 18:52:07 +0100
Message-Id: <20220314175207.274870-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20211117023751.24190-1-feng.tang@intel.com>
References: <20211117023751.24190-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Feng, Thomas,

> On Wed, Nov 17, 2021 at 10:37:51AM +0800, Feng Tang wrote:
> Normally the tsc_sync will get checked every time system enters idle state,
> but Thomas Gleixner mentioned there is still a caveat that a system won't
> enter idle [1], either because it's too busy or configured purposely to not
> enter idle. Setup a periodic timer (every 10 minitues) to make sure the
> check is always on.
> 
> [1]. https://lore.kernel.org/lkml/875z286xtk.fsf@nanos.tec.linutronix.de/
> Signed-off-by: Feng Tang <feng.tang@intel.com>

I can see this timer interrupting my system's nohz_full CPUs. It'd be nice to
be able to avoid the noise. A solution is using 'tsc=reliable', but IIUC this
is not what the flag was created for. Any ideas/suggestions?

Regards,
Nicolas

