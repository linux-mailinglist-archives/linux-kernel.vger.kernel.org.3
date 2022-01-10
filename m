Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCA9489B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiAJOgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:36:38 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:50862 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230078AbiAJOgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:36:37 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20A8JQgr026633;
        Mon, 10 Jan 2022 08:36:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 references : in-reply-to : subject : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=vXlTDALDxvmNiVSmOPhcdB9hLicJ1Rl8w2GVP9FnXR4=;
 b=T2h6n+kDigL1k8nIo5Yk0r8bCNgcCpjcJM/ouuA/K1Qg7aZL0hDH9wIzE7AL88KYKFPb
 AEcz5kv1vBEqf7vtfYNzPRipO9JneHNjuRfMvfeSdVt3Iy5yox88LyzoBDWm78EPLWMa
 KD+yfTATWfOEK8AdUhcuW8hln9qfUzoJXVv8X++ndclxa6S3/CgF8glaAhdWNZ7jWU0T
 BEeq9gm60nVZofM2A4fuFAw7jPJINAzjl7jiW8/Lv42I1eJXfR9EELm200YuopKBR6/n
 Yv1WGRfAZWhJGt9oPRt18nRNf+MqbFM6oXIN8mzX/g+IjXh73YxVE2H6CPfz/0Os2psn 9A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dgfearc12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Jan 2022 08:36:32 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 14:36:31 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 10 Jan 2022 14:36:31 +0000
Received: from LONN2DGDQ73 (unknown [198.90.238.73])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EEAFE46D;
        Mon, 10 Jan 2022 14:36:30 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     'Hans de Goede' <hdegoede@redhat.com>,
        'Mark Brown' <broonie@kernel.org>,
        "'Rafael J . Wysocki'" <rafael@kernel.org>,
        'Len Brown' <lenb@kernel.org>,
        'Mark Gross' <markgross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20211210154050.3713-1-sbinding@opensource.cirrus.com> <20211210154050.3713-7-sbinding@opensource.cirrus.com> <c311642f-38ab-4914-cf92-852e6a20cfc9@redhat.com>
In-Reply-To: <c311642f-38ab-4914-cf92-852e6a20cfc9@redhat.com>
Subject: RE: [PATCH v2 6/6] ACPI: bus-multi-instantiate: Add SPI support
Date:   Mon, 10 Jan 2022 14:36:31 +0000
Message-ID: <00af01d8062f$75aed010$610c7030$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQHKVo1VqSuCeo4owGzltFIRzsdrTwJOwqyRAiYSAMGsVAklYA==
X-Proofpoint-ORIG-GUID: Rur5_MhejF781VNlZkeEmeaVDujI3-6_
X-Proofpoint-GUID: Rur5_MhejF781VNlZkeEmeaVDujI3-6_
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: 21 December 2021 18:32
> To: Stefan Binding <sbinding@opensource.cirrus.com>; Mark Brown
> <broonie@kernel.org>; Rafael J . Wysocki <rafael@kernel.org>; Len =
Brown
> <lenb@kernel.org>; Mark Gross <markgross@kernel.org>
> Cc: linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org; linux-
> acpi@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> patches@opensource.cirrus.com
> Subject: Re: [PATCH v2 6/6] ACPI: bus-multi-instantiate: Add SPI =
support

> > +	ret =3D bmi_spi_count_resources(adev);
> > +	if (ret <=3D 0)
> > +		return ret;
> > +	count =3D ret;
>=20
> Ok, so why not do the following here instead (and drop a whole bunch =
of
> functions above):
>=20
> 	ret =3D acpi_dev_get_resources(adev, &r, bmi_spi_count, &count);
> 	if (ret < 0)
> 		return ret;
>=20
> 	if (count <=3D 0) {
> 		acpi_dev_free_resource_list(&r);
> 		return count;
> 	}
>=20
> 	/* Note we are not freeing the resource list yet here !!! */
>=20
> > +
> > +	bmi->spi_devs =3D devm_kcalloc(dev, count, sizeof(*bmi->spi_devs),
> GFP_KERNEL);
> > +	if (!bmi->spi_devs)
> > +		return -ENOMEM;
> > +
> > +	acpi_data =3D bmi_spi_get_resources(dev, adev, count);
> > +	if (!acpi_data)
> > +		return -ENOMEM;
>=20
> Remove the bmi_spi_get_resources() call here.
>=20
> > +
> > +	for (i =3D 0; i < count && inst_array[i].type; i++) {
>=20
> Write a new:
>=20
> int bmi_get_spi_resource_by_index(list_head *resource_list, struct
> acpi_resource_spi_serialbus *sb_ret, int index)
> {}
>=20
> Helper which walks the list and fills in *sb_ret with the Nth =
(matching index)
> SpiSerialBus resource found in the
> list.
>=20
> And then do:
>=20
> 		ret =3D bmi_get_spi_resource_by_index(&r, &sb, i);
> 		if (ret)
> 			return ret;
>=20
> 		ctrl =3D
> bmi_find_spi_controller(sb.resource_source.string_ptr);
>=20
>=20
> > +		ctlr =3D bmi_find_spi_controller(acpi_data-
> >acpi_data[i].resource_source);
> > +		if (!ctlr) {
> > +			ret =3D -EPROBE_DEFER;
> > +			goto error;
> > +		}
> > +
> > +		spi_dev =3D spi_alloc_device(ctlr);
> > +		if (!spi_dev) {
> > +			dev_err(&ctlr->dev, "failed to allocate SPI device for
> %s\n",
> > +				dev_name(&adev->dev));
> > +			ret =3D -ENOMEM;
> > +			goto error;
> > +		}
> > +
> > +		strscpy(spi_dev->modalias, inst_array[i].type,
> sizeof(spi_dev->modalias));
> > +
>=20
> And replace all the "acpi_data->acpi_data[i].sb." reference below with
> simple "sb.".
>=20
>=20
> > +		if (ctlr->fw_translate_cs) {
> > +			ret =3D ctlr->fw_translate_cs(ctlr,
> > +						    acpi_data-
> >acpi_data[i].sb.device_selection);
> > +			if (ret < 0) {
> > +				spi_dev_put(spi_dev);
> > +				goto error;
> > +			}
> > +			spi_dev->chip_select =3D ret;
> > +		} else {
> > +			spi_dev->chip_select =3D acpi_data-
> >acpi_data[i].sb.device_selection;
> > +		}
> > +
> > +		spi_dev->max_speed_hz =3D acpi_data-
> >acpi_data[i].sb.connection_speed;
> > +		spi_dev->bits_per_word =3D acpi_data-
> >acpi_data[i].sb.data_bit_length;
> > +
> > +		if (acpi_data->acpi_data[i].sb.clock_phase =3D=3D
> ACPI_SPI_SECOND_PHASE)
> > +			spi_dev->mode |=3D SPI_CPHA;
> > +		if (acpi_data->acpi_data[i].sb.clock_polarity =3D=3D
> ACPI_SPI_START_HIGH)
> > +			spi_dev->mode |=3D SPI_CPOL;
> > +		if (acpi_data->acpi_data[i].sb.device_polarity =3D=3D
> ACPI_SPI_ACTIVE_HIGH)
> > +			spi_dev->mode |=3D SPI_CS_HIGH;
> > +
> > +		ret =3D bmi_get_irq(pdev, adev, &inst_array[i]);
> > +		if (ret < 0) {
> > +			spi_dev_put(spi_dev);
> > +			goto error;
> > +		}
> > +		spi_dev->irq =3D ret;
> > +
> > +		snprintf(name, sizeof(name), "%s-%s-%s.%d",
> dev_name(&ctlr->dev), dev_name(dev),
> > +			 inst_array[i].type, i);
> > +		spi_dev->dev.init_name =3D name;
> > +
> > +		ret =3D spi_add_device(spi_dev);
> > +		if (ret) {
> > +			dev_err(&ctlr->dev, "failed to add SPI device %s from
> ACPI: %d\n",
> > +				dev_name(&adev->dev), ret);
> > +			spi_dev_put(spi_dev);
> > +			goto error;
> > +		}
> > +
> > +		dev_dbg(dev, "SPI device %s using chip select %u", name,
> spi_dev->chip_select);
> > +
> > +		bmi->spi_devs[i] =3D spi_dev;
> > +		bmi->spi_num++;
> > +	}
> > +
> > +	if (bmi->spi_num < count) {
> > +		dev_err(dev, "Error finding driver, idx %d\n", i);
> > +		ret =3D -ENODEV;
> > +		goto error;
> > +	}
> > +
> > +	dev_info(dev, "Instantiate %d SPI devices.\n", bmi->spi_num);
>=20
> And here replace the bmi_spi_res_free(acpi_data); call in both exit =
paths
> with:
> acpi_dev_free_resource_list(&r); .
>=20
> To me this way, simply using the already allocated resources from the =
list,
> rather then making a temp copy of them and throwing that away seems =
like
> a simpler solution ?
>=20
> If you go this route, please also remove the struct bmi_spi_acpi and
> struct bmi_spi_sb_acpi data types which you now no longer need.
>=20

I tried to implement this idea, and reuse the resource list, but I hit =
an issue.=20
The resources saved in the list are not "struct acpi_resource", but =
instead the=20
generic "struct resource".
We need the acpi_resource structure to pull the parameters from to be =
able to
create the spi devices.
As far as I know there is no way to convert the "struct resource" into a
"struct acpi_resource". Is there another way to do this?

Thanks,
Stefan

