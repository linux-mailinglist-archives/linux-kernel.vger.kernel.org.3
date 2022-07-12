Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A362571CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiGLOho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGLOhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02AE520F74
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657636660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5KJklFvPCEKfjWJTVQm1grb76tLbmc3mTNZgfa4EqHg=;
        b=EZMnujCqAE8ncL2FJY82XQOVRkRYTZ72DDVDKjjNHfZxC8B8PevINvkLWYXT5YrQexuzN+
        jAJxkqO8UB5Z+t32cSG+uiOKSfQp49GGJIlMsZNUOgrh9jI8yjNAjnHz5D4QfSyWBAHvBY
        P/muBYDmK3G84QGFSJxXNK2sMbQngvg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-2x3P8qvNP_aTYJ5zoX8scA-1; Tue, 12 Jul 2022 10:37:33 -0400
X-MC-Unique: 2x3P8qvNP_aTYJ5zoX8scA-1
Received: by mail-wm1-f72.google.com with SMTP id v18-20020a05600c15d200b003a2d4809386so6797339wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5KJklFvPCEKfjWJTVQm1grb76tLbmc3mTNZgfa4EqHg=;
        b=J4Ql6bQDcR+MwIb9fKDqUdcDgwa/f+sfaLFocsx/AG+hWiQiB93adE394RrYwBhusC
         QG2FfnIJgOcrMdvR3E7cRXrRvscv5tucZYOeN1fAnVcgJKRCfi7bH0LyZKgH+6wBfxny
         ZZRX4GEOWsV6MkvluF/ycguuzm4+bOnaNsBusHKuVeBj5N19QUvNVBdAAM126+UHVYUv
         e0HOIMMOhNokBzYB/oijafHW94XbMfBSP8BhIvwg7EelCyyIVuYuPV+1rNDvEplD9n7E
         2B1LbpzHRrwGvsIQlNHvzL7Hv8mhwOwhASw+CluV+5wPxmzMP7WGrNhz/i0/cJ0ccBvE
         THMw==
X-Gm-Message-State: AJIora+g8BFNyIBjtswqQqxHBYwKrtRLshC0hqLx/vixZIXPs7ca5A3F
        0wTOFdnytsaJ1Q28lHtmQoBAzNcUWwAA67W3hrTwq1WdGswm/e6nZh8G+oWbXPTsoeexjhhPkm3
        y2cci3eFbODkGNuxdpX6gJOKl
X-Received: by 2002:a05:600c:1c0e:b0:3a2:ed0a:420f with SMTP id j14-20020a05600c1c0e00b003a2ed0a420fmr4333338wms.85.1657636651912;
        Tue, 12 Jul 2022 07:37:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tRfeubwulsX/h91nD0OkRVMShZGiduIXtGX98s5dWgdOpnKheWU35gYkWuCD9JV6g0b33+Ng==
X-Received: by 2002:a05:600c:1c0e:b0:3a2:ed0a:420f with SMTP id j14-20020a05600c1c0e00b003a2ed0a420fmr4333321wms.85.1657636651758;
        Tue, 12 Jul 2022 07:37:31 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b0039c747a1e8fsm15526157wmp.7.2022.07.12.07.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:37:31 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tom Rix <trix@redhat.com>, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, rafael.j.wysocki@intel.com,
        qperret@google.com, ionela.voinescu@arm.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] sched/topology: change sched_energy_mutex and
 sched_energy_update to static
In-Reply-To: <20220703153122.4069621-1-trix@redhat.com>
References: <20220703153122.4069621-1-trix@redhat.com>
Date:   Tue, 12 Jul 2022 15:37:30 +0100
Message-ID: <xhsmhwnci75xx.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/22 11:31, Tom Rix wrote:
> sparse reports
> kernel/sched/topology.c:210:1: warning: symbol 'sched_energy_mutex' was not declared. Should it be static?
> kernel/sched/topology.c:211:6: warning: symbol 'sched_energy_update' was not declared. Should it be static?
>
> When the commit listed in the fixes tag happened, the sched_energy_mutex
> and sched_energy_update variable accesses were wrapped by a function and
> the variables were and still are only accessed in the topology.c file.
> So change their storage class specifiers to static.
>
> Fixes: 31f6a8c0a471 ("sched/topology,schedutil: Wrap sched domains rebuild")
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

