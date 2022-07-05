Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F939566476
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiGEHpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiGEHpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 458AD12D06
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657007139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DWDgDXSeP15veDUN7myfR3lyDiOZfm+kMMVhBgTyReM=;
        b=CYxDFMEuWW7OFEnQK31E1PLUbywH6F4NsTzdrQtnyjMZWexOmoDUGQr9MrZI3YjB2jBBDm
        yGCJ799TdfMgWqTqIXOlYyqVXO19apR1R2pZQrIBlwR4DwaepUI7H2Mbt74NpfbDVYrblY
        4cEkqRLtwEyspW/jEkQlv3GVUTve6G8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-oN5uUzedNciNJ-7tIrpO8w-1; Tue, 05 Jul 2022 03:45:37 -0400
X-MC-Unique: oN5uUzedNciNJ-7tIrpO8w-1
Received: by mail-wm1-f70.google.com with SMTP id be8-20020a05600c1e8800b003a069fe18ffso8504533wmb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DWDgDXSeP15veDUN7myfR3lyDiOZfm+kMMVhBgTyReM=;
        b=Q4F5HTB+rUKJiAm09v6wBJYQNHe0dF5CPKRmRzBbWT7v7Jna1Ls4OKLBPj08JhSKZB
         EUlPW6mArh6P7rmT2kBYgbe5mfJJZTVgnS2tEyUwInF/w2UfXKK/x+nv63EQ7beZ43gZ
         CtyoXpFljwL8xDxMLbQg23dd1qZuz9m2bGGEKQtxxCQjOLbdzQ6CPpo20ysPzITr6gid
         lU6VGX647J5VB5d/CfcKva/JkRQ4v4kWRyqo7VCZCDUWhrDwtDBw+AVOUNnQQG2YlM2M
         IjDcGOP/BmyZRhkn1MqT5QQ8lfgwEdmHL0Rj89zixnD6x5FCSwJKKHLWlpjtl/8Lp4HR
         fy4A==
X-Gm-Message-State: AJIora9F96sgwiq9tG/aMEsLbN+pKh//9HS9XJrvoJWCsDlUWGqc9+jq
        HkTcSJULdlGBasBFaFIhFb0bCXPOiCfgAxRv9GQiuuPkYkXJgkl064dNAP36dIoCC2Tx5ADeJWZ
        Pa+oBx+L7q62B+cL2+ZLPbpHO
X-Received: by 2002:a05:6000:1d98:b0:21b:aead:9b6c with SMTP id bk24-20020a0560001d9800b0021baead9b6cmr31106619wrb.531.1657007136796;
        Tue, 05 Jul 2022 00:45:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sqjFerla3g6hrVv4aRjCNbpwklaRFrV9PjgP9oTFN55uTYvAe20TAZptKD/odqD9X3v0f56g==
X-Received: by 2002:a05:6000:1d98:b0:21b:aead:9b6c with SMTP id bk24-20020a0560001d9800b0021baead9b6cmr31106595wrb.531.1657007136594;
        Tue, 05 Jul 2022 00:45:36 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id q9-20020adfdfc9000000b0021d6ec32fdesm2343224wrn.74.2022.07.05.00.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:45:35 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: "Dying CPU not properly vacated" splat
In-Reply-To: <20220622195856.GA1694215@paulmck-ThinkPad-P17-Gen-1>
References: <20220421193821.GA173010@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh4k2h9m26.mognet@vschneid.remote.csb>
 <20220425173320.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh1qxkakof.mognet@vschneid.remote.csb>
 <20220426000328.GY4285@paulmck-ThinkPad-P17-Gen-1>
 <xhsmhy1zr99zt.mognet@vschneid.remote.csb>
 <20220426162445.GG4285@paulmck-ThinkPad-P17-Gen-1>
 <20220622195856.GA1694215@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 05 Jul 2022 08:45:35 +0100
Message-ID: <xhsmhzghof1eo.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 22/06/22 12:58, Paul E. McKenney wrote:
>
> And I hit this on two of fifteen TREE03 runs on a merge of -rcu with
> yesterday's linus/master.  Might be a fluke, but I thought I should
> at least report it.  This is the first time since my last email in
> this thread.
>
>                                                       Thanx, Paul

Did you get anything other than rcu_torture_reader in the task dump this
time?

