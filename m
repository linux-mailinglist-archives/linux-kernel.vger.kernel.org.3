Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480C654F8EF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382705AbiFQOJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382639AbiFQOJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E16AB3FDBB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655474957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F6EdbhXiluBHyzk9hPtJdhL3AM+MH0HBX37VrXg4n4w=;
        b=DPTh2OYwAcMRzAoBUguuWcHEVsBhCQDHRji9deK18tKJuYtcwy5BZ5ROjiBdZJ6LylrC/Z
        c4vSQ/2GXw7JCcDX+6NZRujyCk7B8HtKhR1hJpc6wtda+J6M3xXFA0US8hDW24+6o0u6F9
        VwO1QXobYy5lk1Ua/EQllKwrRBvsmXs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-1p9vXzwEN9uRMNX_R9z8Ag-1; Fri, 17 Jun 2022 10:09:16 -0400
X-MC-Unique: 1p9vXzwEN9uRMNX_R9z8Ag-1
Received: by mail-wm1-f69.google.com with SMTP id p18-20020a05600c23d200b0039c40c05687so1583836wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=F6EdbhXiluBHyzk9hPtJdhL3AM+MH0HBX37VrXg4n4w=;
        b=wIuHa2jLZZfc8gDXWN+0VKmndgU80afhOckBuFzqqpMobY96psGQfMS79WPxqiWCW2
         belMI4Ky1FlHB3izvxJkO6GHDQ8cBVYSi7w0/ZNywaRJ7iE7W/xQpyd1K3MJCdDNmL6c
         PqDW9IO20UP69aFQXERQYOxPFYi/hWyqLu/WHAX1G1FQlL+TKyAN/mg8OlJEMB9YCBnz
         ASMeia3oXTPeWlLOesFwstDWK6eVqeyzUvfmYgY+Acw1XKGPDN+1sIpDFeaLczw840Xz
         3Bf4PZuS9LEBwJpnZoteUQrrjqQuzUsZ3e+nduIxPoNwjOaRSZnLPlXHVcG7vIA9/EWC
         XS2Q==
X-Gm-Message-State: AJIora9+qKmsLswHLxZ/vDsl2OC+3GJEm5lhN6QO3nVlx8tyMUnyvd/N
        tLpQgXhp7tVLVD/LKy7PRnbuUyYRaJiG7GSy74rdj+cb8MZp6Xa/syK9SeBn9rOcAJTficj98qV
        xqcvVecrNsXuybFWBh9c1eQMQ
X-Received: by 2002:a5d:610f:0:b0:21a:ba8:13ad with SMTP id v15-20020a5d610f000000b0021a0ba813admr9330262wrt.594.1655474955337;
        Fri, 17 Jun 2022 07:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1su+8YzScx3J+lUBewvRNNsk3wnxUlADeN6JPjNFKUnQBTyOz6zrEC660l77Gv/+8u4tNzAAg==
X-Received: by 2002:a5d:610f:0:b0:21a:ba8:13ad with SMTP id v15-20020a5d610f000000b0021a0ba813admr9330253wrt.594.1655474955188;
        Fri, 17 Jun 2022 07:09:15 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b0039c96b97359sm5624059wme.37.2022.06.17.07.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:09:13 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        zhangqiao22@huawei.com
Subject: Re: [PATCH 2/2] sched: Remove unused function group_first_cpu()
In-Reply-To: <20220617181151.29980-3-zhangqiao22@huawei.com>
References: <20220617181151.29980-1-zhangqiao22@huawei.com>
 <20220617181151.29980-3-zhangqiao22@huawei.com>
Date:   Fri, 17 Jun 2022 15:09:11 +0100
Message-ID: <xhsmhfsk3756g.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/22 02:11, Zhang Qiao wrote:
> group_first_cpu() is an unused function

as of commit afe06efdf07c ("sched: Extend scheduler's asym packing")

>, remove it.
>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

