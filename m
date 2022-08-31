Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AB45A7815
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiHaHt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiHaHtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:49:04 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60077.outbound.protection.outlook.com [40.107.6.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D6A2D9A;
        Wed, 31 Aug 2022 00:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLlRBBBIXmkwc/1N6VO6csXeZ4JwznIZfNgJ6doY9XNOBguMYdV0wWglBF1hXzZ1a1PTVCj0iNrandJDiEKAQX8ktge5ier6gJg58679yMw5DrRyUWR+wpDncPnez/rX5/Be6Es4R9hBMfCqzf04KAa6rQ0pOv9Y6Rpiqj+ZtYvWXXdZpiOwu/ItvJpQ9cNRrWTnJfPNDqWPVmOJ62gDkSW8vqfx5HzZ9FNhzb06jrgNzLjYmsY8rdM3bY3CGx0zB5YsrxKDGdAM8JHgTsD+6nDxmnaxMKGjNYvsIy/4bK95Hfb0fN5jGg1HfXKcYaYhn3WA+l11Q58Z6mVLaPgx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jG5ZqnreZgIQNmb1THnMzkOgJR8HDHQ3vCPIXFOntAQ=;
 b=T1Gkg9rPTV1mUtMkhuXZp8IzwwUNTe17d8BV3QceEQIEKp0qxdpeiJvAyDSLb2JQXTEMvPXecJFwcOUHwpB0/JJXzLtjiFDoNs5Hy9GX2cstFZQx1mp7OkDTC68jee9IWoq7fwvC5WQ2EWGLYEK/C39jiv7smTJcVzudG4FSmGSxpiHoHwX/PilQIZtEkpb4MusYEVw6MJlAZN7vkWeZso38xgH5Vr+mhPawbLPrbLJ01+jz1dIQwVJ/B2b/N7ZjBvxOH/BJylNtobwuZn9arpJKEzgLogmoQ2eNnm78ET2sZepR+UOGSY8Ss61A5VLSJg4UX4yO6PKhlgqgDa2jxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jG5ZqnreZgIQNmb1THnMzkOgJR8HDHQ3vCPIXFOntAQ=;
 b=VKL6N+ikRtB9YWEmkvsPb3cWhc4DeNgH5NQuTdcgGyWT+HCFU/JIOI/5bWUh65t6prOh3qWikakHQmweqXdMgsoy13ubZ9sWt5NborMjYHY2zcrt+J2hWxEwLlOKQRykwUm5Ypn6kG5cEVJysi3Z3pXQQtIu7ftD0NqEUOpTntGTCAWNtYlCfAbRxhBl4cnFSiK2S5iZKvSaNVsZ7lgU+uCw24jqPc+/DsaJkbksj+9qsrYRcG8ef1fMJ2cYH2rsDCf+bzwJIuGiyJ4gbZVrqCePGuJ2qZdKqw5CRFb7RBWNL35tTwHuPBO71ihAZafqGdiWOkpqmdbsedugWmlqKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by AS8PR04MB7590.eurprd04.prod.outlook.com (2603:10a6:20b:23d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 07:48:43 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::c1b3:1b0c:46fc:4b2b]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::c1b3:1b0c:46fc:4b2b%3]) with mapi id 15.20.5566.019; Wed, 31 Aug 2022
 07:48:43 +0000
Date:   Wed, 31 Aug 2022 15:48:30 +0800
From:   joeyli <jlee@suse.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Ben Boeckel <me@benboeckel.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Malte Gell <malte.gell@gmx.de>,
        Varad Gautam <varad.gautam@suse.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9,2/4] PKCS#7: Check codeSigning EKU for kernel module
 and kexec pe verification
Message-ID: <20220831074830.GU5247@linux-l9pv.suse>
References: <20220825142314.8406-1-jlee@suse.com>
 <20220825142314.8406-3-jlee@suse.com>
 <YwriQqVVs6PLQk3M@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwriQqVVs6PLQk3M@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCPR01CA0190.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::7) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4c7acac-7cc8-4f49-d03b-08da8b253a25
X-MS-TrafficTypeDiagnostic: AS8PR04MB7590:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjpZaBcqzkJyssZyreXe4cH4xC8NPsIEeS+oQBqdMpWaiHFYDDIwqCMDTi6/WTr5cslcgyd2doF8uw7li4VmJZy6p03wsRVb+NRl7T+FcuqhTZyiB9vECuq9eGuXG3cTryjO0+sVHMjVvBDpIlha8Vs1gbRNyznU+V8ot4nbXwxgZ4IN6dw8gtcWGWXprO5cYeaKcgb9GBprq2B7Z8cfagpgrnJwykzQiyF8w/Zy/IAXli0p+CZxGYUykr7HOolWTk9R3BbRdvIRdBw211wFc2+FioLvm9PX284yX8g47yId/CrLaKhaEdQtZI5OqZvDdd/0hU7DOGkrjj0AbIeKiN8ZjulKlU195WT3nzt9qXw+25/trP3emRqnZeGYDYH4GwxtxKFe1Urpb5nbj1QcGqW9towUf4X18R4LiAHuQJX3DgI24Z2XYhKDuEBszGJ8wc/39zq3mVrYlx7Lwkbr/SmgPNKIqIkv75sah0Srtu05qgGp/5RxqxP7sl3/DJLdCu1io/3Z/S1ByjCtIoaorw5zpEHhU6eIuGMN8RkvVcFUroEQdfy/QqFirfcG3vXOcecT/e17ucSwdPdmaAPeLDpnKJB2c6Gyv/v+BlK8kwIM2jtKDYFXX3XSFa8XQ+yEMFc3QcXC/fuFIWQAYZEzDL2WvXeC0D3jiOlG2oEy/2qu3D1w+cNxZmQOX93GmiiX8mFg4bqFHapDonIc8/VEsOCNQgNc2nxYbqIE/8IZX0NxHFZcZdqjKuc8wDtRi6oC66SbLSJwEWfXG/XJDWwusw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(186003)(1076003)(478600001)(66946007)(66476007)(4326008)(8676002)(66556008)(5660300002)(33656002)(6506007)(6486002)(6666004)(41300700001)(36756003)(6512007)(9686003)(26005)(83380400001)(86362001)(316002)(54906003)(2906002)(8936002)(7416002)(15650500001)(38100700002)(6916009)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tmdIjEbyvQHvISvWXShIKmOhXgFIr/ZeRKwWyi4UnxGYpGwCNqsJnq9U2JuX?=
 =?us-ascii?Q?osamuJGlJHs9RTDXVnlxhNyJuci6m8xiQ1RyMUu0WmNt8bC33q7roy3/4xDg?=
 =?us-ascii?Q?l+wjjCjqnDNiMGOH1z4QzjAbWu/sO2PFPN7Po2z/pnTMBub2h669CClL+9hv?=
 =?us-ascii?Q?FDW5jD12KD859e7q7Dxtd+4XS2EbZW+4Io2cri6ZRsn4RQcUtQrr5jjc7HqW?=
 =?us-ascii?Q?Ivv8xb/ccdTTFCFEtIzIUDR7OLu9AZyCjZyD78vVV6lFhZNKzrsfvMrHYaUz?=
 =?us-ascii?Q?1UBmV1AtsE9A+XrHKHzPRfTB++romjS1nhWEgL68JyAdu0VNYH1ccNrL93NF?=
 =?us-ascii?Q?KVvKBeNV0we2gSNjcBU4G4Bs7ZebE97FFNNIDdA/JASdVIj5f4KoVZNDGtQ7?=
 =?us-ascii?Q?C48kAQd61wAKDICE4HfV9ajwcgqODOP8bkR3v9IfDqVuyNMOqs83GwoGfKHl?=
 =?us-ascii?Q?2EfvLWsqXG4jIbikUbwGBzkGmRpPX80Q8DCdIGGg8eiuptkgNapNtl7XWg5m?=
 =?us-ascii?Q?TUY1ZneVVvY7BSo6TluNRpS34mVEgtMs2+9FqbvGw80oC8lv0cvQY/NcCJ4P?=
 =?us-ascii?Q?EtoCXZRIpiY2wBXRNZDze31H88fo1ASwBnsLDck9qeOhG/r2vJ7f/rNPLExx?=
 =?us-ascii?Q?Uyz9tBGnZviJ+dWQoa4FoiC6lP8M0vca1X+3BA3xVD4E1SsZEIWSYs/ey0go?=
 =?us-ascii?Q?sb0QETsAZJ3gwIZn1cyKJY4rDUXND4t8ybRJOBZzlwGv6QBYWTOZGefvmOSk?=
 =?us-ascii?Q?Mt5hNa4TefRJWUf50DaPrLGZgIv2HtIpntlcxO/1illeN3YPm/kphWQ1fHas?=
 =?us-ascii?Q?vx/dYCvJelMHZSfvdCfNYrNgIoigbH1sLSkEJ5fbEUbw8tbL9dkQ4kdrn8Zm?=
 =?us-ascii?Q?QDlPKIYZqCg68u72zha+ZeEBU8OK+1yRNVKE7GqZK594dhFVb/Rn6LicUVWz?=
 =?us-ascii?Q?CGSzab2czaiL2UYzvrSBHOORmxxCgxIXVrdwSIf6fDRGWwYbj++xWOe2ONLz?=
 =?us-ascii?Q?We2vudddZSG6Kjz7MPGerheNrXTA5kbsPS3CVgIVyucbetgsdDrrNg8YnICW?=
 =?us-ascii?Q?8UXMzqONh+tbW2g81AYrM1Co5WSdTFmTdZ9HcfBNkPSHBDCjsrRZiPzHQQAL?=
 =?us-ascii?Q?Uj0kSAbM55ERY9EmypXl03Rb5eEpwenYlln3RAXlLv6yo6TMx/c+r05M2uQm?=
 =?us-ascii?Q?cccCnFOma3ZsoDZI33EhI6kguv+Ol/v0vzp49jmAn4vGJQieRPJI9DLmRlWi?=
 =?us-ascii?Q?j9pbcNKNxzLWWTza9h79pBYe24+yR7Qk0k6lHvFdMcvNsaju/K9zK29vmQnt?=
 =?us-ascii?Q?Jziz5UhclRI6GcIvEfhacANa7CHoutK56bucxhKNNBK6OCMTbw7Xfb2k2ajX?=
 =?us-ascii?Q?0GWTsfwDeB8KKJOIxf+1MgvcjybAnUGaPFBIXh0N79fdX+dVCGSh4r3gqr1b?=
 =?us-ascii?Q?xri3vrPoFqo9urWL3bZraX/SXoBKm7dtst2Scj/rvMkVlUfwlqsMjIxHfV7F?=
 =?us-ascii?Q?M89bzU3A0FH3CdNIUaOMrsTPGPI+iqhHcsNa7VXlgo+5WjnulNdPGuj2SimR?=
 =?us-ascii?Q?pyiKrk1pRswAZyERriB7CJ5RefJXNlqAUIan8owI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c7acac-7cc8-4f49-d03b-08da8b253a25
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 07:48:43.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJy7Y4rr+A9nfiv4H3Q7cujOMw1MuhNkUUe8wjh+D5HdpbhUO8qRd6xUw93KFmSU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On Sun, Aug 28, 2022 at 06:34:26AM +0300, Jarkko Sakkinen wrote:
> On Thu, Aug 25, 2022 at 10:23:12PM +0800, Lee, Chun-Yi wrote:
> > This patch adds the logic for checking the CodeSigning extended
> > key usage when verifying signature of kernel module or
> > kexec PE binary in PKCS#7.
> 
> Pretty much the same feedback as for 1/4.
>

I will also change this description.

Thanks
Joey Lee
 
> > 
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > ---
> >  certs/blacklist.c                    |  5 ++--
> >  certs/system_keyring.c               |  4 +--
> >  crypto/asymmetric_keys/Kconfig       |  9 ++++++
> >  crypto/asymmetric_keys/pkcs7_trust.c | 43 ++++++++++++++++++++++++++--
> >  crypto/asymmetric_keys/selftest.c    |  2 +-
> >  include/crypto/pkcs7.h               |  4 ++-
> >  include/keys/system_keyring.h        |  7 +++--
> >  7 files changed, 63 insertions(+), 11 deletions(-)
> > 
> > diff --git a/certs/blacklist.c b/certs/blacklist.c
> > index 41f10601cc72..fa41454055be 100644
> > --- a/certs/blacklist.c
> > +++ b/certs/blacklist.c
> > @@ -282,11 +282,12 @@ int add_key_to_revocation_list(const char *data, size_t size)
> >   * is_key_on_revocation_list - Determine if the key for a PKCS#7 message is revoked
> >   * @pkcs7: The PKCS#7 message to check
> >   */
> > -int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
> > +int is_key_on_revocation_list(struct pkcs7_message *pkcs7,
> > +			      enum key_being_used_for usage)
> >  {
> >  	int ret;
> >  
> > -	ret = pkcs7_validate_trust(pkcs7, blacklist_keyring);
> > +	ret = pkcs7_validate_trust(pkcs7, blacklist_keyring, usage, false);
> >  
> >  	if (ret == 0)
> >  		return -EKEYREJECTED;
> > diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> > index 5042cc54fa5e..66737bfb26de 100644
> > --- a/certs/system_keyring.c
> > +++ b/certs/system_keyring.c
> > @@ -263,13 +263,13 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
> >  			goto error;
> >  		}
> >  
> > -		ret = is_key_on_revocation_list(pkcs7);
> > +		ret = is_key_on_revocation_list(pkcs7, usage);
> >  		if (ret != -ENOKEY) {
> >  			pr_devel("PKCS#7 platform key is on revocation list\n");
> >  			goto error;
> >  		}
> >  	}
> > -	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
> > +	ret = pkcs7_validate_trust(pkcs7, trusted_keys, usage, true);
> >  	if (ret < 0) {
> >  		if (ret == -ENOKEY)
> >  			pr_devel("PKCS#7 signature not signed with a trusted key\n");
> > diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
> > index 3df3fe4ed95f..189536bd0f9a 100644
> > --- a/crypto/asymmetric_keys/Kconfig
> > +++ b/crypto/asymmetric_keys/Kconfig
> > @@ -85,4 +85,13 @@ config FIPS_SIGNATURE_SELFTEST
> >  	depends on ASYMMETRIC_KEY_TYPE
> >  	depends on PKCS7_MESSAGE_PARSER
> >  
> > +config CHECK_CODESIGN_EKU
> > +	bool "Check codeSigning extended key usage"
> > +	depends on PKCS7_MESSAGE_PARSER=y
> > +	depends on SYSTEM_DATA_VERIFICATION
> > +	help
> > +	  This option provides support for checking the codeSigning extended
> > +	  key usage when verifying the signature in PKCS#7. It affects kernel
> > +	  module verification and kexec PE binary verification.
> > +
> >  endif # ASYMMETRIC_KEY_TYPE
> > diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
> > index 9a87c34ed173..087d3761d9a8 100644
> > --- a/crypto/asymmetric_keys/pkcs7_trust.c
> > +++ b/crypto/asymmetric_keys/pkcs7_trust.c
> > @@ -16,12 +16,40 @@
> >  #include <crypto/public_key.h>
> >  #include "pkcs7_parser.h"
> >  
> > +#ifdef CONFIG_CHECK_CODESIGN_EKU
> > +static bool check_eku_by_usage(struct key *key, enum key_being_used_for usage)
> > +{
> > +	struct public_key *public_key = key->payload.data[asym_crypto];
> > +	bool ret = true;
> > +
> > +	switch (usage) {
> > +	case VERIFYING_MODULE_SIGNATURE:
> > +	case VERIFYING_KEXEC_PE_SIGNATURE:
> > +		ret = !!(public_key->ext_key_usage & EKU_codeSigning);
> > +		if (!ret)
> > +			pr_warn("The signer '%s' key is not CodeSigning\n",
> > +				key->description);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +	return ret;
> > +}
> > +#else
> > +static bool check_eku_by_usage(struct key *key, enum key_being_used_for usage)
> > +{
> > +	return true;
> > +}
> > +#endif
> > +
> >  /*
> >   * Check the trust on one PKCS#7 SignedInfo block.
> >   */
> >  static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
> >  				    struct pkcs7_signed_info *sinfo,
> > -				    struct key *trust_keyring)
> > +				    struct key *trust_keyring,
> > +				    enum key_being_used_for usage,
> > +				    bool check_eku)
> >  {
> >  	struct public_key_signature *sig = sinfo->sig;
> >  	struct x509_certificate *x509, *last = NULL, *p;
> > @@ -112,6 +140,10 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
> >  	return -ENOKEY;
> >  
> >  matched:
> > +	if (check_eku && !check_eku_by_usage(key, usage)) {
> > +		key_put(key);
> > +		return -ENOKEY;
> > +	}
> 
> Why you don't just open code this to those rare call
> sites where it is needed?
> 
> I counted that there is exactly one call site.
> 
> >  	ret = verify_signature(key, sig);
> >  	key_put(key);
> >  	if (ret < 0) {
> > @@ -135,6 +167,8 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
> >   * pkcs7_validate_trust - Validate PKCS#7 trust chain
> >   * @pkcs7: The PKCS#7 certificate to validate
> >   * @trust_keyring: Signing certificates to use as starting points
> > + * @usage: The use to which the key is being put.
> > + * @check_eku: Check EKU (Extended Key Usage)
> >   *
> >   * Validate that the certificate chain inside the PKCS#7 message intersects
> >   * keys we already know and trust.
> > @@ -156,7 +190,9 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
> >   * May also return -ENOMEM.
> >   */
> >  int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
> > -			 struct key *trust_keyring)
> > +			 struct key *trust_keyring,
> > +			 enum key_being_used_for usage,
> > +			 bool check_eku)
> >  {
> >  	struct pkcs7_signed_info *sinfo;
> >  	struct x509_certificate *p;
> > @@ -167,7 +203,8 @@ int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
> >  		p->seen = false;
> >  
> >  	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
> > -		ret = pkcs7_validate_trust_one(pkcs7, sinfo, trust_keyring);
> > +		ret = pkcs7_validate_trust_one(pkcs7, sinfo, trust_keyring,
> > +					       usage, check_eku);
> >  		switch (ret) {
> >  		case -ENOKEY:
> >  			continue;
> > diff --git a/crypto/asymmetric_keys/selftest.c b/crypto/asymmetric_keys/selftest.c
> > index fa0bf7f24284..756e9f224d8a 100644
> > --- a/crypto/asymmetric_keys/selftest.c
> > +++ b/crypto/asymmetric_keys/selftest.c
> > @@ -212,7 +212,7 @@ int __init fips_signature_selftest(void)
> >  		if (ret < 0)
> >  			panic("Certs selftest %d: pkcs7_verify() = %d\n", i, ret);
> >  
> > -		ret = pkcs7_validate_trust(pkcs7, keyring);
> > +		ret = pkcs7_validate_trust(pkcs7, keyring, VERIFYING_MODULE_SIGNATURE, false);
> >  		if (ret < 0)
> >  			panic("Certs selftest %d: pkcs7_validate_trust() = %d\n", i, ret);
> >  
> > diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
> > index 38ec7f5f9041..5d87b8a02f79 100644
> > --- a/include/crypto/pkcs7.h
> > +++ b/include/crypto/pkcs7.h
> > @@ -30,7 +30,9 @@ extern int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
> >   * pkcs7_trust.c
> >   */
> >  extern int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
> > -				struct key *trust_keyring);
> > +				struct key *trust_keyring,
> > +				enum key_being_used_for usage,
> > +				bool check_eku);
> >  
> >  /*
> >   * pkcs7_verify.c
> > diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> > index 91e080efb918..bb33b527240e 100644
> > --- a/include/keys/system_keyring.h
> > +++ b/include/keys/system_keyring.h
> > @@ -9,6 +9,7 @@
> >  #define _KEYS_SYSTEM_KEYRING_H
> >  
> >  #include <linux/key.h>
> > +#include <keys/asymmetric-type.h>
> >  
> >  enum blacklist_hash_type {
> >  	/* TBSCertificate hash */
> > @@ -81,13 +82,15 @@ static inline int is_binary_blacklisted(const u8 *hash, size_t hash_len)
> >  
> >  #ifdef CONFIG_SYSTEM_REVOCATION_LIST
> >  extern int add_key_to_revocation_list(const char *data, size_t size);
> > -extern int is_key_on_revocation_list(struct pkcs7_message *pkcs7);
> > +extern int is_key_on_revocation_list(struct pkcs7_message *pkcs7,
> > +				     enum key_being_used_for usage);
> >  #else
> >  static inline int add_key_to_revocation_list(const char *data, size_t size)
> >  {
> >  	return 0;
> >  }
> > -static inline int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
> > +static inline int is_key_on_revocation_list(struct pkcs7_message *pkcs7,
> > +					    enum key_being_used_for usage)
> >  {
> >  	return -ENOKEY;
> >  }
> > -- 
> > 2.26.2
> > 
> 
> BR, Jarkko
