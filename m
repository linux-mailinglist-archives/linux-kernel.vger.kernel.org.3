Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1EF4D37D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiCIRff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiCIRf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:35:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9331C107A88;
        Wed,  9 Mar 2022 09:34:28 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229FZBIT032580;
        Wed, 9 Mar 2022 17:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=m7ZL9gJXj+cYSZ0S6BaXlIhcR2fxNcDQpAja9ENQ0Ko=;
 b=aXrMKpK3v3yYn8ve3gOnWAUEYWHh6FyhT9r7+55AXHMSfRH6XobCmZdespiXxhSv6iVc
 XcKOJHOukqrM3yiQAVNXRUMRe7gCsOY4PZ0AOlmbgf6a648ViOlVvZQPqDJsjKR9gzHb
 tR65Nv53Fx4bg/g42LEVM2i6KrH3YHzujlPUxkUGysWubOPcTsypm2n+fpirA9+HvRdv
 hI0Vhk20s4aOkM+HWHNj4JfPg7Yn5nCPC9zk8+ISSOoVrjahlRvoNXUBMszVhd5homiT
 4zL7kZmx3hETC4dWSx0JDPiPemmxz/PE+1PgX+46nn61TdqfxxfevgfUt6ANBmfh4fZS yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3env4v50sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 17:34:00 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 229GoYRk001697;
        Wed, 9 Mar 2022 17:34:00 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3env4v50s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 17:33:59 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 229HDHth029428;
        Wed, 9 Mar 2022 17:33:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3eky4j2t4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 17:33:57 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 229HXsgV52429172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Mar 2022 17:33:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 018E8A405C;
        Wed,  9 Mar 2022 17:33:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5324CA405B;
        Wed,  9 Mar 2022 17:33:51 +0000 (GMT)
Received: from sig-9-65-73-171.ibm.com (unknown [9.65.73.171])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Mar 2022 17:33:51 +0000 (GMT)
Message-ID: <30ee58d0b48ce96b4c9a334019c4b8ae8394bef0.camel@linux.ibm.com>
Subject: Re: [PATCH 3/4] KEYS: CA link restriction
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Wed, 09 Mar 2022 12:33:50 -0500
In-Reply-To: <068F32E0-B202-4B20-9DE7-57373EF71BFE@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
         <20220301173651.3435350-4-eric.snowberg@oracle.com>
         <47f3654e-892d-a35a-e77c-70ada1ebcf43@linux.ibm.com>
         <2415444C-AD8F-4F03-8B1C-C0770F83ADAE@oracle.com>
         <e2dd58cd6074ae692256333b43b5ecde70bcdbdd.camel@linux.ibm.com>
         <67456A73-8B72-4DB6-8E23-7C603661A0A4@oracle.com>
         <22860730-d615-5683-6af0-05b6f4f3e71d@linux.ibm.com>
         <e10f2161aaa69a9d301b3a16a37cbab266318aee.camel@linux.ibm.com>
         <068F32E0-B202-4B20-9DE7-57373EF71BFE@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PmVRSgXkte4mCHmfPygVo7BMQSe6LDaV
X-Proofpoint-ORIG-GUID: eKCns3uVCSNnUTKXC7_y_MxzzJe_RiI8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_07,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=559 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-08 at 18:02 +0000, Eric Snowberg wrote:

> > On Mar 8, 2022, at 5:45 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:

> > Agreed, as long as the other two criteria are also met: CA and keyUsage
> > should be required and limited to keyCertSign.
> 
> I have added the key_is_ca in the public_key header.  I can look at adding the usage
> too. Before doing this I would like to understand the "limited to" above.  Many CA keys 
> that have keyCertSign set, also have digitalSignature set for key usage.  For 
> example:
> 
> http://cacerts.digicert.com/DigiCertEVCodeSigningCA-SHA2.crt
> 
> Are you saying we would want to exclude a CA like the one above, since it as the 
> digitalSignature usage set too?  

Yes, the "machine" keyring is defining a new root of trust to support
allowing end-users the ability "to add their own keys and sign modules
they trust".  There should be a clear distinction between  keys used
for certificate signing from those used for code signing.  Certificate
signing keys should be added to the .machine keyring.  Code signing
keys should be added to the IMA keyring.

thanks,

Mimi

