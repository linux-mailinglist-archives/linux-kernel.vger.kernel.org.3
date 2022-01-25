Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B2349B4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357337AbiAYNMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:12:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1575474AbiAYNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:09:48 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PD5qpY018084;
        Tue, 25 Jan 2022 13:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=DOwUVylm3hgoXpGtEI5hpuFUf0xRn2a+F5Eh8YQ5IkI=;
 b=Jzb2tem9WLKWqa1WbXwb/RXC7Pw6JXM8fita0ZDDsNPnv1BJG5unAtdPNxaj6YZHTFT/
 OT9CnRD5tuJW+4QswNSy6gRt9DTU1D03m+ojNPPYql7IDUF70BZsOI8HolRQ8tDvUeyb
 1nebrrkCjHMkBt32QGdsXIuwjInUbEI4jI4vN9drUSBqQrg53EeYXhpovxk1m/eVEa2T
 NXch1f9Qs549n2HxZwlFw0zxTRVrsbnRj9NBjVdMlEzSGCCrjmQW+6fuweG2Ib/AsJkW
 WhUPemjUn7N8giUIx4ymtYNaT2AJvtRULDO9An3eSvu6jtsVhB2n6/Xz7ND6dAx68Fn/ dQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dthef8fdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 13:09:23 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PD3Poo018548;
        Tue, 25 Jan 2022 13:09:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3dr9j96an6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 13:09:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PD9JI229164000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 13:09:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F56811C04A;
        Tue, 25 Jan 2022 13:09:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD78811C050;
        Tue, 25 Jan 2022 13:09:18 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Jan 2022 13:09:18 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
References: <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
        <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
        <Yao35lElOkwtBYEb@kroah.com>
        <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
        <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
        <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
        <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
        <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
        <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
        <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com>
        <Ye/w/lOf4f8+8fDt@hirez.programming.kicks-ass.net>
Date:   Tue, 25 Jan 2022 14:09:18 +0100
In-Reply-To: <Ye/w/lOf4f8+8fDt@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 25 Jan 2022 13:45:50 +0100")
Message-ID: <yt9dbl00rmgx.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _kYmxngVCR81fmKqNZ-dl-KA8w8WkKTk
X-Proofpoint-GUID: _kYmxngVCR81fmKqNZ-dl-KA8w8WkKTk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_02,2022-01-25_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1011 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=947 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> Now the documentation states we need this super speed A<->A cable, but
> could you also update the documentation for usb-c ? There's a fair
> number of usb-c only devices out there now.

Stupid beginners question: Would every USB3 A-A cable work, or are the
debug cables special? I've read the RX/TX pairs have to be swapped, but
to me it looks like that's always the case?

I'm just asking because i tried to debug a before-framebuffer crash on
my Thinkpad X1, but didn't have any luck getting xdbc running. Maybe
because of the bug above. Would be nice if someone could confirm whether
that should work with every USB3 A-A cable.

Thanks,
Sven
