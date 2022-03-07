Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC864D0B9E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244901AbiCGXDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbiCGXDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:03:00 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C3E4D61C;
        Mon,  7 Mar 2022 15:02:05 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227MKeSx006271;
        Mon, 7 Mar 2022 23:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CFwKlekU1PBsgaEJRwpNrri29MPy0+lafy81A1tEMzk=;
 b=e+Qk59rmDS3Iere5pS6c/hVrRpyr/bS0X9vS6v2VCdFczpjz5QQVGMk6a5qQJFEIds+F
 gZMQQyjtc14msPUUochMl/9uHkZn1n9VSnWZo3IQiEP/Q3/k7BMBujDYNyYSU8vpkZNh
 NIHwuk5ra1GI4nhy7EyG0OUoOvSBRLn7YgfcCiAsY9b5+qA5iS4yDWU9oGiqPi6/5cuY
 63hA/kC0plZlInkcYYUDEYQF4N6Jh6EnbXrDkvyI2u0zhblUW3h6YHrZL+JF5lvX6s1/
 TTnizEcDqx7VA3n9Ohk3wzNA3GWZcXgXO9xSgae3eRvhBELjeMoiOhf4G+vSVdNaNERf Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3engn5pbxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 23:01:52 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 227MsEGF027962;
        Mon, 7 Mar 2022 23:01:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3engn5pbws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 23:01:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 227Mxu34017016;
        Mon, 7 Mar 2022 23:01:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3eky4hwtn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 23:01:49 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 227N1kxW49611184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Mar 2022 23:01:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42F1BA406B;
        Mon,  7 Mar 2022 23:01:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E21ECA406E;
        Mon,  7 Mar 2022 23:01:43 +0000 (GMT)
Received: from sig-9-65-67-225.ibm.com (unknown [9.65.67.225])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Mar 2022 23:01:43 +0000 (GMT)
Message-ID: <e2dd58cd6074ae692256333b43b5ecde70bcdbdd.camel@linux.ibm.com>
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
Date:   Mon, 07 Mar 2022 18:01:43 -0500
In-Reply-To: <2415444C-AD8F-4F03-8B1C-C0770F83ADAE@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
         <20220301173651.3435350-4-eric.snowberg@oracle.com>
         <47f3654e-892d-a35a-e77c-70ada1ebcf43@linux.ibm.com>
         <2415444C-AD8F-4F03-8B1C-C0770F83ADAE@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f41ARC6yxgvb8MJAb-Tz6Pt_sxfpqcDd
X-Proofpoint-GUID: p2bDuE9O5v-DjwMtdWv87DMdKKBRHHtz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_12,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-07 at 18:06 +0000, Eric Snowberg wrote:
> 
> >> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
> >> index 6b1ac5f5896a..49bb2ea7f609 100644
> >> --- a/crypto/asymmetric_keys/restrict.c
> >> +++ b/crypto/asymmetric_keys/restrict.c
> >> @@ -108,6 +108,49 @@ int restrict_link_by_signature(struct key *dest_keyring,
> >>  	return ret;
> >>  }
> >>  +/**
> >> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
> >> + * @dest_keyring: Keyring being linked to.
> >> + * @type: The type of key being added.
> >> + * @payload: The payload of the new key.
> >> + * @trust_keyring: Unused.
> >> + *
> >> + * Check if the new certificate is a CA. If it is a CA, then mark the new
> >> + * certificate as being ok to link.
> > 
> > CA = root CA here, right?
> 
> Yes, I’ll update the comment

Updating the comment is not enough.  There's an existing function named
"x509_check_for_self_signed()" which determines whether the certificate
is self-signed.

thanks,

Mimi

