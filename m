Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2C525555
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357859AbiELTEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357853AbiELTEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:04:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A1D21E403;
        Thu, 12 May 2022 12:04:29 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CIRVVN012874;
        Thu, 12 May 2022 19:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=H29RDK2yJl5oRBJrLnfkhfz5cXgstDB5uPjuDwdtEPQ=;
 b=cVwm+jJhU599VQrZ0odMq4n8G9pf/dQ/N3fKr0hceljlVZ/ARIE9lBedSAFLmWqZyYfb
 nFJgA1oQeJAj0iwoLdsrMRbc/w1X1XHRhnlFCSydomFMvS1T5uzAvBOEznaDSXQK9IIo
 uy2NNymCFTYdK1EoCcTxhdHtrLpjWC3JYfM4LfkuJSJ6daflJLn+3vU8eT1MUwDUGSfp
 2VNEFcPXkoo5BoC6bZ147NiSzLPsmpBYcTzH+7yR84spwbXXBa/Ye8Hobcaj8GN6nUj5
 GbZXsZreVS+GcubKA+wS1abOc77LVzgBRX7sg9xQqQDCQGGs/yNzDyzIimduKLTEB8iT qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g173b9ar3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:04:26 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CIjJd2012975;
        Thu, 12 May 2022 19:04:26 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g173b9aqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:04:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CIvNgN022308;
        Thu, 12 May 2022 19:04:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3fyrkk3bk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:04:23 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CJ4JO149676722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 19:04:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C9EBA4054;
        Thu, 12 May 2022 19:04:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 933ECA405C;
        Thu, 12 May 2022 19:04:18 +0000 (GMT)
Received: from osiris (unknown [9.145.44.123])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 12 May 2022 19:04:18 +0000 (GMT)
Date:   Thu, 12 May 2022 21:04:17 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/8] s390: allow to build with llvm's integrated assembler
Message-ID: <Yn1aMcKTD0v3FevS@osiris>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <CAKwvOdkXy0nhS-S+dOAsSO+mpj2dCuZ4aUTe=upPV8epfTA7Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkXy0nhS-S+dOAsSO+mpj2dCuZ4aUTe=upPV8epfTA7Aw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Eo6A3lLQ9p42Ac8B2xFgV2lCfD6_Ercd
X-Proofpoint-GUID: pzRmEjic2ySjkRjN8oWTY23Qr3REfSs6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_16,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=655 priorityscore=1501
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 12:48:34PM -0700, Nick Desaulniers wrote:
> On Wed, May 11, 2022 at 5:05 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > A couple of patches which in result make it finally possible to build the
> > kernel for s390 with llvm's integrated assembler. Several configs build
> > without errors or warnings, and the kernel also works as expected.
> >
> > Note that patch 6 ("s390/boot: workaround llvm IAS bug") reveals a
> > miscompile. This looks like a bug in the instruction definitions of the mvc
> > and clc instructions(?). I'd like to ask people to look into this, since
> > this silently generated broken code.
> >
> > This patch series is based on linux-next, which contains two additional
> > required s390 specific patches to make llvm's IAS work.
> 
> I did a quick test of just a defconfig via:
> $ ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- make CC=clang -j72 defconfig all
> and this assembled then booted in qemu for me. Thanks for the work
> that went into this!
> 
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Will add this too. Thank you!
