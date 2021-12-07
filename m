Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438B746BDC2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbhLGOgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:36:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231591AbhLGOgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:36:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7EN0Ud013257;
        Tue, 7 Dec 2021 14:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=NkT4aCkcUZeDo2cwgUAOg/+G/WZAQboHT/K4wLYl7A0=;
 b=Qf3qyil3Lb7Un+vlO5C5Hen4gEQIUaqqdwCaF0cdVJ0gF5rG+JL6J1hKMCMp0TI0ayAj
 cH/CuItp8vp6i3kz1lRJQn5FUlsaNuq5Q0LFHV3Gwwcd8WmZmvS7US7IQKWmtFoN3pm7
 4qr/ISPP/jLSeuPCBvf4XxI/3Jx4WIkmhIeXumP/7hwXhcxzA6yGKbqxdnF1C7nej2vY
 vPvxNFaIFQ1mMbxKpFat+bafZHh+FudxjUWGcD54GGn56XsY+CiO5LX8m0Um72rOMjVE
 mGSV5aDVFVICiC8SsK5ymkHLQ3GOK0IbLzzHV2ic2OrmCq2ump6bYvBpRzKnBX6+w87L tw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ct9b0g5ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 14:32:43 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7EHo8I031329;
        Tue, 7 Dec 2021 14:32:43 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma05wdc.us.ibm.com with ESMTP id 3cqyyaddv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 14:32:43 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7EWf6K28836300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 14:32:41 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A074AC059;
        Tue,  7 Dec 2021 14:32:41 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09087AC06C;
        Tue,  7 Dec 2021 14:32:40 +0000 (GMT)
Received: from localhost (unknown [9.211.135.78])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  7 Dec 2021 14:32:40 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc/pseries: read the lpar name from the firmware
In-Reply-To: <20211203154321.13168-1-ldufour@linux.ibm.com>
References: <20211203154321.13168-1-ldufour@linux.ibm.com>
Date:   Tue, 07 Dec 2021 08:32:39 -0600
Message-ID: <87bl1so588.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7PT63JThHSeXXaemJ-Bbkmk_PvlUmWjV
X-Proofpoint-ORIG-GUID: 7PT63JThHSeXXaemJ-Bbkmk_PvlUmWjV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112070087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Laurent Dufour <ldufour@linux.ibm.com> writes:
> +/*
> + * PAPR defines, in section "7.3.16 System Parameters Option", the token 55 to
> + * read the LPAR name.
> + */
> +#define SPLPAR_LPAR_NAME_TOKEN	55
> +static void read_lpar_name(struct seq_file *m)
> +{
> +	int rc, len, token;
> +	union {
> +		char raw_buffer[RTAS_DATA_BUF_SIZE];
> +		struct {
> +			__be16 len;

This:

> +			char name[RTAS_DATA_BUF_SIZE-2];
                                       ^^^^^^

should be 4000, not (4K - 2), according to PAPR (it's weird and I don't
know the reason).


> +		};
> +	} *local_buffer;
> +
> +	token = rtas_token("ibm,get-system-parameter");
> +	if (token == RTAS_UNKNOWN_SERVICE)
> +		return;
> +
> +	local_buffer = kmalloc(sizeof(*local_buffer), GFP_KERNEL);
> +	if (!local_buffer)
> +		return;
> +
> +	do {
> +		spin_lock(&rtas_data_buf_lock);
> +		memset(rtas_data_buf, 0, RTAS_DATA_BUF_SIZE);
> +		rc = rtas_call(token, 3, 1, NULL, SPLPAR_LPAR_NAME_TOKEN,
> +			       __pa(rtas_data_buf), RTAS_DATA_BUF_SIZE);
> +		if (!rc)
> +			memcpy(local_buffer->raw_buffer, rtas_data_buf,
> +			       RTAS_DATA_BUF_SIZE);
> +		spin_unlock(&rtas_data_buf_lock);
> +	} while (rtas_busy_delay(rc));
> +
> +	if (rc != 0) {
> +		pr_err_once(
> +			"%s %s Error calling get-system-parameter (0x%x)\n",
> +			__FILE__, __func__, rc);

The __FILE__ and __func__ in the message seem unnecessary, and rc should
be reported in decimal so the error meaning is apparent.

Is there a reasonable fallback for VMs where this parameter doesn't
exist? PowerVM partitions should always have it, but what do we want the
behavior to be on other hypervisors?


> +	} else {
> +		/* Force end of string */
> +		len = be16_to_cpu(local_buffer->len);
> +		if (len >= (RTAS_DATA_BUF_SIZE-2))
> +			len = RTAS_DATA_BUF_SIZE-2;

Could use min() or clamp(), and it would be better to build the
expression using the value of sizeof(local_buffer->name).

> +		local_buffer->name[len] = '\0';

If 'len' can be (RTAS_DATA_BUF_SIZE - 2), then this writes past the end
of the buffer, no?

