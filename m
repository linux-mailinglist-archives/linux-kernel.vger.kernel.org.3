Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446394B028D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiBJBzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:55:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiBJBzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:55:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 051C32B6B1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644457515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqS6aRbHUDdzpsG8gLAbed/VgqomfvLKE7ZO5PCIOxw=;
        b=EAWUge6OpYCxHvMymJyzXL0u6KeNKQUU7UmOf3hbi6wNGumwmhGn5JElsE2ja4BUF7CKTk
        tWV90Y9Iz8kOCpJDBcOWk+GdTEN4/DxWQvUL0LMEPMqlwoZQT5MxIet6fgh4z1SXxc4awf
        wo4tIlJ5A3FTplwCKy4zT8zvpt8Bozs=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-Nf0j83U2PPCMUeuPK1h7bg-1; Wed, 09 Feb 2022 18:44:43 -0500
X-MC-Unique: Nf0j83U2PPCMUeuPK1h7bg-1
Received: by mail-io1-f71.google.com with SMTP id q7-20020a6bf207000000b006129589cb60so2892722ioh.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 15:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=QqS6aRbHUDdzpsG8gLAbed/VgqomfvLKE7ZO5PCIOxw=;
        b=6njCH4D30kIlTz5YY8LzOnGGtOyzHfX7VpfZoQ+ishFHhqUMHcV//NJ0BMSLQIYn2n
         BXXlFVm9hgGaClBWIeB5qVfLDnvCUBisZ8qC5MVZ8NsUtfEH1Luje41JxWowxW1BNxhU
         Whlp0hnWlAXNsEE6sUQnZ8G2R/wriVc19b3uuGHfchkWCCZn5jvOBiC7Gwpk2O/77Eel
         I8WizMKAFZWLksIqUhGfysZzYtz5eWf+t0syUD+2XVVY86ZCCM/MlQsaBZKhPSpyyFWV
         fcMYe0K144v9gbKGNn3OFUnDbuLDVy8aI9ihK/t75AN5wzKTyrEdO8LELqb8nqTj0cyd
         vrVQ==
X-Gm-Message-State: AOAM530KMlOsO4JOvu9EPOn/Uil334WCOzQPuvweXnhozrwy6G0hUiit
        VyePMa6X/VVno2POrX3y5XakZXahv872fEPTkduXNof06Hcv89vVRjBhQmZqrCpJW2ZzV/hV/3g
        /HHmDmsvpQ//meXdRpgrEgnxP
X-Received: by 2002:a05:6602:2209:: with SMTP id n9mr2470393ion.106.1644450283117;
        Wed, 09 Feb 2022 15:44:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxT6HD2F4lnfPsmgFD3PhnkTPzmCmvBRL9NupZBHsvlbk18vuDpteUdQty0XS8Ul8opPEqcow==
X-Received: by 2002:a05:6602:2209:: with SMTP id n9mr2470381ion.106.1644450282952;
        Wed, 09 Feb 2022 15:44:42 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w19sm10870685iov.16.2022.02.09.15.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:44:42 -0800 (PST)
Date:   Wed, 9 Feb 2022 16:44:40 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <jgg@nvidia.com>,
        <cohuck@redhat.com>, <mgurtovoy@nvidia.com>, <yishaih@nvidia.com>,
        <linuxarm@huawei.com>, <liulongfang@huawei.com>,
        <prime.zeng@hisilicon.com>, <jonathan.cameron@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: Re: [RFC v4 7/8] hisi_acc_vfio_pci: Add support for VFIO live
 migration
Message-ID: <20220209164440.0d77284c.alex.williamson@redhat.com>
In-Reply-To: <20220208133425.1096-8-shameerali.kolothum.thodi@huawei.com>
References: <20220208133425.1096-1-shameerali.kolothum.thodi@huawei.com>
        <20220208133425.1096-8-shameerali.kolothum.thodi@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 13:34:24 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> +
> +static struct hisi_acc_vf_migration_file *
> +hisi_acc_vf_stop_copy(struct hisi_acc_vf_core_device *hisi_acc_vdev)
> +{
> +	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> +	struct device *dev = &hisi_acc_vdev->vf_dev->dev;
> +	struct hisi_acc_vf_migration_file *migf;
> +	int ret;
> +
> +	if (unlikely(qm_wait_dev_not_ready(vf_qm))) {
> +		dev_info(dev, "QM device not ready, no data to transfer\n");
> +		return 0;
> +	}

This return value looks suspicious and I think would cause a segfault
in the calling code:

+		migf = hisi_acc_vf_stop_copy(hisi_acc_vdev);
+		if (IS_ERR(migf))
+			return ERR_CAST(migf);
+		get_file(migf->filp);
+		hisi_acc_vdev->saving_migf = migf;
+		return migf->filp;

Thanks,
Alex

