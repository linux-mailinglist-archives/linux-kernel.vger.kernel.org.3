Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9B349B5AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385500AbiAYOFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:05:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10054 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244466AbiAYOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:02:00 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PDa1B1026888;
        Tue, 25 Jan 2022 14:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=hM+U2dlqP46OUo4fwxEPEJfGWMF4re/nYmzSS2JOeRc=;
 b=hZCiJ2CAWduSzQpBnyHIC33rqkEsePodhpbctvVzBHdarFOvdKVcjQ25zxq+UuskPeYX
 cP/LFODS+jLGf8G7mQvfJCjjM1OdRQs4b0e11EU7kRIb+gCSg6OsUVfR2N8RlVKG3d2y
 P2gR/7qPM9zRqc6bChkHBf90Ujawqt3Gtqi0b/ykT1JIVLXOQTl2Q1l4dohHYN8bzBSB
 YypXC+oaCk+KKRjYU1SQxF253PlFOL9lgIig7Tvze5Opln/ZYwMfjENF9OF9ZwtXTuSt
 Q3JY+cObvrKsaYnIFVyHbXZnmBwNqcurivUyT5HqMI6n5AHbyFMltFWTY+evXnORzAHp FA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dthxvrvuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 14:01:41 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PDwLK9020971;
        Tue, 25 Jan 2022 14:01:39 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3dr96jetbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 14:01:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PE1aLX42860816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 14:01:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0E7742047;
        Tue, 25 Jan 2022 14:01:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 930654204B;
        Tue, 25 Jan 2022 14:01:36 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Jan 2022 14:01:36 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
References: <Yao35lElOkwtBYEb@kroah.com>
        <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
        <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
        <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
        <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
        <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
        <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
        <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com>
        <Ye/w/lOf4f8+8fDt@hirez.programming.kicks-ass.net>
        <yt9dbl00rmgx.fsf@linux.ibm.com>
        <YfAA+age1zo3lxIB@hirez.programming.kicks-ass.net>
Date:   Tue, 25 Jan 2022 15:01:36 +0100
In-Reply-To: <YfAA+age1zo3lxIB@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 25 Jan 2022 14:54:01 +0100")
Message-ID: <yt9dh79rnccf.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iYUsxqAKHKiGZOdJeA37eLFAyGmJX0Zv
X-Proofpoint-ORIG-GUID: iYUsxqAKHKiGZOdJeA37eLFAyGmJX0Zv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_02,2022-01-25_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 mlxlogscore=765 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Jan 25, 2022 at 02:09:18PM +0100, Sven Schnelle wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>> 
>> > Now the documentation states we need this super speed A<->A cable, but
>> > could you also update the documentation for usb-c ? There's a fair
>> > number of usb-c only devices out there now.
>> 
>> Stupid beginners question: Would every USB3 A-A cable work, or are the
>> debug cables special? I've read the RX/TX pairs have to be swapped, but
>> to me it looks like that's always the case?
>
> I'm using a random USB3 A-A cable (it came with an HDMI frame grabber of
> of AliExpress). The official one has a wire missing I think, to avoid
> ground loops or something like that.
>
> The easiest thing to do is try the runtime DBC option:
>
>   echo enable > /sys/bus/pci/devices/0000:00:14.0/dbc
>
> If that works you can see what it takes to make the earlyprintk one
> working. This thread seems to have much of that covered.

Thanks, the sysfs test works for me. I have two A-A cables, one is from
a cheap PCI-e extender, the other one from a KVM switch. Both work,
which is great. So i assume that most A-A cable would work. I'm building
a new kernel now with the patch on top, lets see.

Thanks!
