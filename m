Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25284D8B09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbiCNRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238425AbiCNRrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E891BF5F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647279963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YEJG0IObRkUr69r2f7J23FXjPgRCTJSeRdoCwh8LUrA=;
        b=FjY3WnLXJFEGZDsR8GU0MH+aJTMb8Tq2Lj2HHQRn+Pg8zKBFJccv7hQBEZMtCT5huAtUOV
        cdMvdK/DXjUfXd/MH8vDS0SRYezuxElCpkG02S6N4zTZofIyKUQzEPbdqQsZRy06L7v7+t
        LZVe3T23HOOzC9STZ2KyQ43zAM2+uhA=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-P9QDZGrLPk2rNMTIWU-GZA-1; Mon, 14 Mar 2022 13:46:02 -0400
X-MC-Unique: P9QDZGrLPk2rNMTIWU-GZA-1
Received: by mail-il1-f197.google.com with SMTP id 5-20020a056e0211a500b002c6552a9c5fso9692696ilj.22
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEJG0IObRkUr69r2f7J23FXjPgRCTJSeRdoCwh8LUrA=;
        b=QlF4i5VzBPWyQjM9Pl/gVBa/duhUwzOtMHGn53EKiLmNctz+9UQ2qHRTgQx5Mx2JLb
         +z9V+1BCKf+6PWXA6dgs/381THYBF+GcZ1I557d3CTC48uQd+duaQDNaQ784AtTSlywt
         hwRMCUwzEMtDD5ozRhmt4C0vXaNC07iegHNuyLM9uOGRotCvbii3GqCymaNTv1+wqh9E
         93Jyiax+Ue3MBTKnhVGkmvxVQcMlq4mfU87P7W27ItvVQ18D7X946WkWUW4GphNSesrZ
         gWM4+m9mVxEabvM71+1ga1We6oYhtqgxC1EWKNMvZxUCxxk3cD5BNISIPP8cH+i3O7hT
         CW1Q==
X-Gm-Message-State: AOAM531H5KrQ6tlpo31YnWf79Ar01chCleEpQVyEtK1uScLCJEfmWW1K
        exF3lvukbCEjyH6kiOFw/4W0cisEyFx1mIy/HzA7Dc/z8vkSEeY9J8UovlAYBxs20RQAvE0jFDP
        PZFhOAa6tAjwDz+RCVkhAKTSS
X-Received: by 2002:a05:6602:3c5:b0:613:8644:591c with SMTP id g5-20020a05660203c500b006138644591cmr20675142iov.161.1647279961389;
        Mon, 14 Mar 2022 10:46:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZJJA4WojvmGdmtZ74f1wNxVgekXaAUaGHvuviIsQF6/0w1VCSMfKnNrXxBYkfIXxrO2Rn+w==
X-Received: by 2002:a05:6602:3c5:b0:613:8644:591c with SMTP id g5-20020a05660203c500b006138644591cmr20675084iov.161.1647279960174;
        Mon, 14 Mar 2022 10:46:00 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id b2-20020a923402000000b002c25b16552fsm9227068ila.14.2022.03.14.10.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 10:45:59 -0700 (PDT)
Date:   Mon, 14 Mar 2022 11:45:58 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        liulongfang <liulongfang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v9 0/9] vfio/hisilicon: add ACC live migration driver
Message-ID: <20220314114558.2cdd57fc.alex.williamson@redhat.com>
In-Reply-To: <df217839a41b47dc94ef201dfe379e4e@huawei.com>
References: <20220308184902.2242-1-shameerali.kolothum.thodi@huawei.com>
        <df217839a41b47dc94ef201dfe379e4e@huawei.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 17:26:59 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> Hi Alex,
>=20
> > -----Original Message-----
> > From: Shameerali Kolothum Thodi
> > Sent: 08 March 2022 18:49
> > To: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-crypto@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org; alex.williamson@redhat.com; jgg@nvidia.c=
om;
> > cohuck@redhat.com; mgurtovoy@nvidia.com; yishaih@nvidia.com;
> > kevin.tian@intel.com; Linuxarm <linuxarm@huawei.com>; liulongfang
> > <liulongfang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> > Jonathan Cameron <jonathan.cameron@huawei.com>; Wangzhou (B)
> > <wangzhou1@hisilicon.com>
> > Subject: [PATCH v9 0/9] vfio/hisilicon: add ACC live migration driver
> >=20
> > Hi,
> >=20
> > This series attempts to add vfio live migration support for HiSilicon
> > ACC VF devices based on the new v2 migration protocol definition and
> > mlx5 v9 series discussed here[0].
> >=20
> > v8 --> v9
> > =C2=A0- Added acks by Wangzhou/Longfang/Yekai
> > =C2=A0- Added R-by tags by Jason.
> > =C2=A0- Addressed comments=C2=A0by Alex on v8.
> > =C2=A0- Fixed the pf_queue pointer assignment error in patch #8.
> > =C2=A0- Addressed=C2=A0comments from Kevin,
> >  =C2=A0 =C2=A0-Updated patch #5 commit log msg with a clarification tha=
t VF
> > =C2=A0 =C2=A0 =C2=A0migration BAR assignment is fine if migration suppo=
rt is not there.
> >  =C2=A0 =C2=A0-Added QM description to patch #8 commit msg. =20
>=20
> Hope there is nothing pending for this series now to make it to next.
> I know ack from Bjorn is still pending for patch #3, and I have
> sent a ping last week and also CCd him on that patch.
>=20
> Please let me know if there is anything I missed.=20

Hi Shameer,

Nothing still pending from my end, as soon as we can get an ack on
patch #3 and barring issues in the interim, I'll merge it.  Thanks,

Alex

