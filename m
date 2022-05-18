Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153EC52BF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbiERPdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbiERPdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AAB772E25
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652887986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=If23kdHTceSEYKXKE6Rbf1RvUnlpNNaxoB7vfIUd8FM=;
        b=aWOLf4maGRSUpbYlOrOp9FSFQWd7uD3ciyw5zz63nJUcpnHxkXhoMZKVVEyxnlqVlsAwJF
        6mc7OuE8b7/NSTT0ANpNRgV1s1GeSG+kT116+/8PcTxpCkaef4GXDrw/r8hRNJtyuG88Aj
        9SFb7pAUjNwfj2U4Q5FAYIYWYJjEt48=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-K0KnTpSeOhWpeDS4sxYX2Q-1; Wed, 18 May 2022 11:33:05 -0400
X-MC-Unique: K0KnTpSeOhWpeDS4sxYX2Q-1
Received: by mail-wm1-f69.google.com with SMTP id q128-20020a1c4386000000b003942fe15835so1006219wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=If23kdHTceSEYKXKE6Rbf1RvUnlpNNaxoB7vfIUd8FM=;
        b=qbdq6pNaV48yA2UbRqZwuA22GL8KAfeQhOg8CE8rPhzlrY9VsxKuPItCc/VTVYiSW/
         AZ7tJaiACnL7EvIFlNxFF2L4jSjZ/4PBZOQ//Kj2+FXUgiqG5G9uosPsjUkmMokr48BG
         9rMwibcyVdmqfYhXa2lQfgepwzkwoGWkdDK+LUkbdIqRmjaJU6txE3hFSEMAaWU9HDey
         r6d+WPJH5EusDn8wUf93ICPxRM189UsqRENCkC2IRlRse0rVIWaDFfgG7QvhLvmaTgfQ
         7jXu2YihXTaADO28287twkO/i8dFSZ/mE0gPr/7jCAyAPeU04GKHvYsoId+B5gTFCW/5
         9GlQ==
X-Gm-Message-State: AOAM531chip3vqhNMYYlvbosPqI+Y/KWHkM/S1+t+iyNGWQnnvaWru1s
        vcR93szpM+hNE+g9eTO0yLpZzUYXkqS2KxqcvStKIxswP/ZdrDRtA/SCSFxV+2iLbXsJ0TxaVX/
        wxGhLU0K0sUVtnPKn2rTIF367
X-Received: by 2002:a05:6000:1f17:b0:20e:6626:5ac7 with SMTP id bv23-20020a0560001f1700b0020e66265ac7mr198651wrb.489.1652887984216;
        Wed, 18 May 2022 08:33:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyC4QL3ss4tcNj+kCaydzyjvNMiNzbn7Wsw9jiEksWluXaxD1xLX0ocCIhgrevOhkRnOBUXiA==
X-Received: by 2002:a05:6000:1f17:b0:20e:6626:5ac7 with SMTP id bv23-20020a0560001f1700b0020e66265ac7mr198628wrb.489.1652887984025;
        Wed, 18 May 2022 08:33:04 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1d02:ba00:f4f8:7394:c8:7ddf? ([2a0c:5a80:1d02:ba00:f4f8:7394:c8:7ddf])
        by smtp.gmail.com with ESMTPSA id p3-20020a1c2903000000b003942a244ed7sm1947897wmp.28.2022.05.18.08.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 08:33:03 -0700 (PDT)
Message-ID: <6690c4c7119839a784d0d96523e832a10e04fcca.camel@redhat.com>
Subject: Re: [PATCH 00/21] rcu/context-tracking: Merge RCU eqs-dynticks
 counter to context tracking v2
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 18 May 2022 17:33:02 +0200
In-Reply-To: <20220503100051.2799723-1-frederic@kernel.org>
References: <20220503100051.2799723-1-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-03 at 12:00 +0200, Frederic Weisbecker wrote:
> This mixes up the RCU dynticks counter and the context tracking state
> updates into a single atomic instruction. This may serve several
> purposes:
>=20
> 1) Improve CPU isolation with deferring some disturbances until sensitive
>    userspace workload completes and goes to the kernel. This can take
>    several forms, for example smp_call_function_housekeeping() or
>    on_each_housekeeping_cpu() to enqueue and execute work on all
>    housekeeping CPUs. Then an atomic operation on ct->state can defer
>    the work on nohz_full CPUs until they run in kernel (or IPI them
>    if they are in kernel mode), see this proposal by Peter:
>    https://lore.kernel.org/all/20210929151723.162004989@infradead.org/#r
>=20
> 2) Unearth sysidle (https://git.kernel.org/pub/scm/linux/kernel/git/paulm=
ck/linux-rcu.git/commit/?h=3Dsysidle.2017.05.11a&id=3Dfe5ac724d81a3c7803e60=
c2232718f212f3f38d4)
>    This feature allowed to shutdown the tick on the last housekeeping
>    CPU once the rest of the system is fully idle. We needed some proper
>    fully ordered context tracking for that.
>=20
> Inspired by Peterz: https://lore.kernel.org/all/20210929151723.162004989@=
infradead.org
>=20
> Passed 100 hours of TREE01.
>=20
> ---

For the whole series:

Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Thanks!

--=20
Nicol=C3=A1s S=C3=A1enz

