Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7269F4D182C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbiCHMql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiCHMqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:46:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBA73A5FD;
        Tue,  8 Mar 2022 04:45:42 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2289dBf7013864;
        Tue, 8 Mar 2022 12:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sz/3PD2prJ9VfKtA9ntYFayzp2x088MjfJvxpS7+9Tc=;
 b=XZFETExXbErQzGq1Wk79xppM0HdoSd2MKJDA5BBIS8oCvn0EGAYhh44MpE3MM5d4/VR2
 6Vgi6Rf1+ElzaxNibtDemGnRaTJeacc79CMJe1r5AjUDl/vII+eyTi9AG8GPDJ3JjT2E
 BPi91Iu3XZvHrk4axAPwtK/7d6h4WGboBre6JfWbgvKyymM/045TSYycamyi/CxgZFel
 RXB61/knJMk1Ci1esdFx7hrS8WMPYaLst4nDLRAl3Zb24r6+1BM8dRpgFX029JaJp7t5
 4ZTvpHPI0/yaN7RBaPTJevQPscYx6WeGl+SO8wvnYa/LfwsFwtiUOkvSuYBmKFkED8l4 sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enxs02bbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:45:13 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 228ChLkQ014960;
        Tue, 8 Mar 2022 12:45:13 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enxs02bag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:45:13 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228Cc162027409;
        Tue, 8 Mar 2022 12:45:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3ekyg8yetr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:45:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228CXvfe49086938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 12:33:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C83AA52051;
        Tue,  8 Mar 2022 12:45:06 +0000 (GMT)
Received: from sig-9-65-67-225.ibm.com (unknown [9.65.67.225])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4B65352052;
        Tue,  8 Mar 2022 12:45:04 +0000 (GMT)
Message-ID: <e10f2161aaa69a9d301b3a16a37cbab266318aee.camel@linux.ibm.com>
Subject: Re: [PATCH 3/4] KEYS: CA link restriction
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>
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
Date:   Tue, 08 Mar 2022 07:45:03 -0500
In-Reply-To: <22860730-d615-5683-6af0-05b6f4f3e71d@linux.ibm.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
         <20220301173651.3435350-4-eric.snowberg@oracle.com>
         <47f3654e-892d-a35a-e77c-70ada1ebcf43@linux.ibm.com>
         <2415444C-AD8F-4F03-8B1C-C0770F83ADAE@oracle.com>
         <e2dd58cd6074ae692256333b43b5ecde70bcdbdd.camel@linux.ibm.com>
         <67456A73-8B72-4DB6-8E23-7C603661A0A4@oracle.com>
         <22860730-d615-5683-6af0-05b6f4f3e71d@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NLzGotlm2HPoT9_7IcXq-KR9yeq45avh
X-Proofpoint-ORIG-GUID: kWQFY81U4qGmQUAGNqHjWhXskBXhkVtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-07 at 21:31 -0500, Stefan Berger wrote:
> 
> On 3/7/22 18:38, Eric Snowberg wrote:
> > 
> > 
> >> On Mar 7, 2022, at 4:01 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>
> >> On Mon, 2022-03-07 at 18:06 +0000, Eric Snowberg wrote:
> >>>
> >>>>> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
> >>>>> index 6b1ac5f5896a..49bb2ea7f609 100644
> >>>>> --- a/crypto/asymmetric_keys/restrict.c
> >>>>> +++ b/crypto/asymmetric_keys/restrict.c
> >>>>> @@ -108,6 +108,49 @@ int restrict_link_by_signature(struct key *dest_keyring,
> >>>>> 	return ret;
> >>>>> }
> >>>>> +/**
> >>>>> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
> >>>>> + * @dest_keyring: Keyring being linked to.
> >>>>> + * @type: The type of key being added.
> >>>>> + * @payload: The payload of the new key.
> >>>>> + * @trust_keyring: Unused.
> >>>>> + *
> >>>>> + * Check if the new certificate is a CA. If it is a CA, then mark the new
> >>>>> + * certificate as being ok to link.
> >>>>
> >>>> CA = root CA here, right?
> >>>
> >>> Yes, I’ll update the comment
> >>
> >> Updating the comment is not enough.  There's an existing function named
> >> "x509_check_for_self_signed()" which determines whether the certificate
> >> is self-signed.
> > 
> > Originally I tried using that function.  However when the restrict link code is called,
> > all the necessary x509 information is no longer available.   The code in
> > restrict_link_by_ca is basically doing the equivalent to x509_check_for_self_signed.
> > After verifying the cert has the CA flag set, the call to public_key_verify_signature
> > validates the cert is self signed.
> > 
> Isn't x509_cert_parse() being called as part of parsing the certificate? 
> If so, it seems to check for a self-signed certificate every time. You 
> could add something like the following to x509_check_for_self_signed(cert):
> pub->x509_self_signed = cert->self_signed = true;
> 
> This could then reduce the function in 3/4 to something like:
> 
> return payload->data[asym_crypto]->x509_self_signed;

Agreed, as long as the other two criteria are also met: CA and keyUsage
should be required and limited to keyCertSign.

thanks,

Mimi

