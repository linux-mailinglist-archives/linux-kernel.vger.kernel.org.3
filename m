Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201D7470983
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245681AbhLJS6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:58:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238645AbhLJS6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639162495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z8/jLpkPkpa/1rZSiq6Pu8X7FeoiXVsgqwxR4PDhzsY=;
        b=X9fKUuQF+xmgSmQeJAcsDGpqwmfyYuZIRr7cm3KRNL6GKQAXX7RZkjoORmK8lr6hD/nPXK
        BUcWHrDdJGGSaUoTFshqBM442imB1KTNgYqXefTkiZPch/2RSv73wZ1jxMslCVEqsDri6G
        ugwO0nnN5llErJNsf2VRWlZv3uz5C4M=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-t8Dl2DFNOUSw-jeePKEjFA-1; Fri, 10 Dec 2021 13:54:53 -0500
X-MC-Unique: t8Dl2DFNOUSw-jeePKEjFA-1
Received: by mail-lj1-f197.google.com with SMTP id s16-20020a2ea710000000b0021b674e9347so3273805lje.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8/jLpkPkpa/1rZSiq6Pu8X7FeoiXVsgqwxR4PDhzsY=;
        b=lG+DBmahaGJzCwQEv95Z8N1xMAnzz+1QzmxykUmPgUj9gi+UCWg2T0f0MhtaQo8Xb6
         Re1d+vWT+925TFsVCX2O5wF5tV2HVzaK1iqgP+1xmJ7XrMEhnMQdJempH3JcXr9YjKw5
         4AMqDu6pQNQIfAHFyc5RVZYJ+JPGdwUETsjSO+87iIaUUTlJWwry0tzGLum2oQ8k4wwj
         SjP91Rc2tJgBdLB3Gh//F6BWG4+BeHNuhiTrgd3JKe4G5nUKqnlvqgvV6IEFHUcBswpC
         LCfmWDcydIJLy3dVW3nlKBzTGTC57KJ+mM/S7mQQVaOKUySzMOvE1Wy+ECVELNZCCEpH
         9Zcw==
X-Gm-Message-State: AOAM533gWzZxPZ3FVBy4veHjU41OoUAdEJhqZzFUwsToiGZfcMWkplGL
        AE32yQQhgGD3eg9hB3mJBWCxCYD3zzWhBAxCPmC7L1rqwFWoVlGmxc9dhokoFaqafvK1izMLlrH
        RQId83+t5RrC+5il7+7CAI9DnOukLWZrVbsOFbBYf
X-Received: by 2002:a05:6512:4024:: with SMTP id br36mr14222116lfb.137.1639162492290;
        Fri, 10 Dec 2021 10:54:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZxrADo9jepEXUsylfOenB+SdQLJrls+4HZ8IrmtQPhabf4gI2ORq9UTW57nabamLAUBTRgU0K2of0nKr3ae4=
X-Received: by 2002:a05:6512:4024:: with SMTP id br36mr14222018lfb.137.1639162491964;
 Fri, 10 Dec 2021 10:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20210903152430.244937-1-nitesh@redhat.com> <CAFki+L=9Hw-2EONFEX6b7k6iRX_yLx1zcS+NmWsDSuBWg8w-Qw@mail.gmail.com>
 <87bl29l5c6.ffs@tglx> <CAFki+Lmrv-UjZpuTQWr9c-Rymfm-tuCw9WpwmHgyfjVhJgp--g@mail.gmail.com>
 <CAFki+L=5sLN+nU+YpSSrQN0zkAOKrJorevm0nQ+KdwCpnOzf3w@mail.gmail.com> <87ilvwxpt7.ffs@tglx>
In-Reply-To: <87ilvwxpt7.ffs@tglx>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Fri, 10 Dec 2021 13:54:40 -0500
Message-ID: <CAFki+LkhMeLKCjPy7HwKjc8nVHw5Br5nhCi3kZXu9aReChEj1A@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] genirq: Cleanup the abuse of irq_set_affinity_hint()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        huangguangbin2@huawei.com, huangdaode@huawei.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Alex Belits <abelits@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>, rostedt@goodmis.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ingo Molnar <mingo@kernel.org>, jbrandeb@kernel.org,
        akpm@linuxfoundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        chris.friesen@windriver.com, Marc Zyngier <maz@kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>, pjwaskiewicz@gmail.com,
        Stefan Assmann <sassmann@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>, james.smart@broadcom.com,
        Ken Cox <jkc@redhat.com>, faisal.latif@intel.com,
        shiraz.saleem@intel.com, tariqt@nvidia.com,
        Alaa Hleihel <ahleihel@redhat.com>,
        Kamal Heib <kheib@redhat.com>, borisp@nvidia.com,
        saeedm@nvidia.com,
        "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Al Stone <ahs3@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
        bjorn.andersson@linaro.org, chunkuang.hu@kernel.org,
        yongqiang.niu@mediatek.com, baolin.wang7@gmail.com,
        Petr Oros <poros@redhat.com>, Ming Lei <minlei@redhat.com>,
        Ewan Milne <emilne@redhat.com>, jejb@linux.ibm.com,
        kabel@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, kashyap.desai@broadcom.com,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        shivasharan.srikanteshwara@broadcom.com,
        sathya.prakash@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        suganath-prabu.subramani@broadcom.com, ley.foon.tan@intel.com,
        jbrunet@baylibre.com, johannes@sipsolutions.net,
        snelson@pensando.io, lewis.hanly@microchip.com, benve@cisco.com,
        _govind@gmx.com, jassisinghbrar@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 1:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Dec 10 2021 at 08:51, Nitesh Lal wrote:
> > On Wed, Nov 24, 2021 at 5:16 PM Nitesh Lal <nilal@redhat.com> wrote:
> >> > The more general question is whether I should queue all the others or
> >> > whether some subsystem would prefer to pull in a tagged commit on top of
> >> > rc1. I'm happy to carry them all of course.
> >> >
> >>
> >> I am fine either way.
> >> In the past, while I was asking for more testing help I was asked if the
> >> SCSI changes are part of Martins's scsi-fixes tree as that's something
> >> Broadcom folks test to check for regression.
> >> So, maybe Martin can pull this up?
> >>
> >
> > Gentle ping.
> > Any thoughts on the above query?
>
> As nobody cares, I'll pick it up.
>

Sounds good to me.
Thank you!

--
Nitesh

