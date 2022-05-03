Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ADC518D6F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiECTxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiECTxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:53:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B4E3EA86
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:49:31 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243J1UIL022213;
        Tue, 3 May 2022 19:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=WLZLXscr2VBP3BdiRkQ3rfSjgF3tQrVA/XAtG/j9RXY=;
 b=P0FJnPOTXZSKSrqNeO5lseIQFJOmpKLteMCA8i57RsJ9p717BuDvdK+MPJSbNASYoU/A
 dXViSLH8b6AcmOTp1edwrjsLTisMCdYJ37gtZA5pbAm7hKkd5k4IV7VGadUKTfTLI0rk
 lRxMy8fyCLVA6Lijtun2FPOwD1TnEdxQf1y1cXlx2WRC1iuaTjooReG2MBsZ1+j5F/4f
 W3bxGGcNXjI9Q8b4MV8bcVhXQj9yWfXKBTX9dqqqoczjYJ4H023FAW7OlGKlKbehlM3m
 Gqc2xsexfV6xpFaRjJBsxB8SNUwbW/SNK0geuGBZ38UK9CS1/7cXUOGUIPGimbWOt8ak VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fu8u6thk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 19:49:03 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 243J1kDr023386;
        Tue, 3 May 2022 19:49:02 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fu8u6thjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 19:49:02 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 243JmfcE002899;
        Tue, 3 May 2022 19:49:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3fscdk32d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 19:49:00 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 243JmuSq23724376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 May 2022 19:48:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 722ED42041;
        Tue,  3 May 2022 19:48:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE07F4203F;
        Tue,  3 May 2022 19:48:56 +0000 (GMT)
Received: from osiris (unknown [9.145.13.65])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  3 May 2022 19:48:56 +0000 (GMT)
Date:   Tue, 3 May 2022 21:48:55 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Message-ID: <YnGHJ7oroqF+v1u+@osiris>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-24-Liam.Howlett@oracle.com>
 <20220428201947.GA1912192@roeck-us.net>
 <20220429003841.cx7uenepca22qbdl@revolver>
 <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
 <20220502001358.s2azy37zcc27vgdb@revolver>
 <20220501172412.50268e7b217d0963293e7314@linux-foundation.org>
 <Ym+v4lfU5IyxkGc4@osiris>
 <20220502133050.kuy2kjkzv6msokeb@revolver>
 <YnAn3FI9aVCi/xKd@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnAn3FI9aVCi/xKd@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bI5So3mPXdQRVQdgmVXx9GXvSXlaKqu_
X-Proofpoint-GUID: Gelui_emMWTs-GJS8TzHUuqq2kXjrreL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_08,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=634 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205030122
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 08:50:04PM +0200, Heiko Carstens wrote:
> On Mon, May 02, 2022 at 01:31:00PM +0000, Liam Howlett wrote:
> > * Heiko Carstens <hca@linux.ibm.com> [220502 06:18]:
> > > On Sun, May 01, 2022 at 05:24:12PM -0700, Andrew Morton wrote:
> > > > (cc S390 maintainers)
> > > > (cc stable & Greg)
...
> > > > > booting.  The last thing I see is:
> > > > > 
> > > > > "[    4.668916] Spectre V2 mitigation: execute trampolines"
> > > > > 
> > > > > I've bisected back to commit e553f62f10d9 (mm, page_alloc: fix
> > > > > build_zonerefs_node())
> > > > > 
> > > > > With the this commit, I am unable to boot one out of three times.  When
> > > > > using the previous commit I was not able to get it to hang after trying
> > > > > 10+ times.  This is a qemu s390 install with KASAN on and I see no error
> > > > > messages.  I think it's likely it is this patch, but no guaranteed.
...
> > > Liam, could you share your kernel config?
> > 
> > Sure thing.  See attached.
> 
> So, I can reproduce the hanging system now. However this looks like a
> qemu problem on s390, since I can reproduce this only with Qemu+TCG.
> Qemu with kvm works without any problems (same if I use z/VM as
> hypervisor).
> 
> Janosch, Claudio, can you have a look at this please?

So, at least for me this problem also exists with plain v5.17.
Switching off KASAN, or alternatively switching to KASAN_INLINE
"fixes" it for me with Qemu+TCG.

Liam, could you please also try to disable KASAN in your config? With
that I think we can be almost sure this could be some bug in Qemu.
