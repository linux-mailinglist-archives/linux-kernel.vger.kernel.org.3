Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707264E2719
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347660AbiCUNBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiCUNB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:01:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9929D554B1;
        Mon, 21 Mar 2022 06:00:03 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LBXwE5009417;
        Mon, 21 Mar 2022 13:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nb+eZgd/L3hUIsTLzUPpyQsbglrU+Z5Q/iraarKtADw=;
 b=VE0EbZ02401lAsSmuzdZyAhyVQ6Kcfe6rN75ABuYOX6h0IoKBBl/6TvQFD0+OnNGO4X8
 ibI26gXIQIiAQ8YobP8UJGAirauVks/9MFXPf1euoTuvpIHLT/kBOffZQbgTK0UV/z5G
 L5zS/7ps8HeHuOEJkvE8xgmIrFbqHIrzfFwdxLnNN6dPO8oSY2ey5OOWL3WqbbqtlU1t
 55/vNyJH77Ri6Hyk66Wa7tDs9y5lFDkPUYigeNYH3EXipqaMnW7O6T7pyN6E65+sYQ2w
 zgMo198QmaLfqu0Z7xWnC/f/NDNdZ7D4d9bY4jGXhd/++Otxj2RQmA4dvg7CyRGn9Dvt EA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3exb60ptat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 13:00:01 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22LCvPjC009137;
        Mon, 21 Mar 2022 13:00:00 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 3ew6t98np4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 13:00:00 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22LCxwgt32965086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 12:59:58 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7542AC062;
        Mon, 21 Mar 2022 12:59:58 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BD2DAC05E;
        Mon, 21 Mar 2022 12:59:58 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 21 Mar 2022 12:59:58 +0000 (GMT)
Message-ID: <1e9263cb-8a3e-a3d8-01c8-0893934f8235@linux.ibm.com>
Date:   Mon, 21 Mar 2022 08:59:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v6 3/5] ima: permit fsverity's file digests in the IMA
 measurement list
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220318182151.100847-1-zohar@linux.ibm.com>
 <20220318182151.100847-4-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220318182151.100847-4-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9e7_RL_HMHKsINwoII3BlF8Zvx2bv-Pp
X-Proofpoint-GUID: 9e7_RL_HMHKsINwoII3BlF8Zvx2bv-Pp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_05,2022-03-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203210081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/22 14:21, Mimi Zohar wrote:
> Permit fsverity's file digest (a hash of struct fsverity_digest) to be
> included in the IMA measurement list, based on the new measurement
> policy rule 'digest_type=verity' option.
> 
> To differentiate between a regular IMA file hash from an fsverity's
> file digest, use the new d-ngv2 format field included in the ima-ngv2
> template.
> 
> The following policy rule requires fsverity file digests and specifies
> the new 'ima-ngv2' template, which contains the new 'd-ngv2' field.  The
> policy rule may be constrained, for example based on a fsuuid or LSM
> label.
> 
> measure func=FILE_CHECK digest_type=verity template=ima-ngv2
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   Documentation/ABI/testing/ima_policy      |  9 ++++++
>   Documentation/security/IMA-templates.rst  |  8 +++++
>   security/integrity/ima/ima_api.c          | 38 +++++++++++++++++++++--
>   security/integrity/ima/ima_policy.c       | 38 ++++++++++++++++++++++-
>   security/integrity/ima/ima_template_lib.c |  4 ++-
>   security/integrity/integrity.h            |  3 +-
>   6 files changed, 95 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 839fab811b18..2e0c501ce9c8 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -51,6 +51,9 @@ Description:
>   			appraise_flag:= [check_blacklist]
>   			Currently, blacklist check is only for files signed with appended
>   			signature.
> +			digest_type:= verity
> +			    Require fs-verity's file digest instead of the
> +			    regular IMA file hash.
>   			keyrings:= list of keyrings
>   			(eg, .builtin_trusted_keys|.ima). Only valid
>   			when action is "measure" and func is KEY_CHECK.
> @@ -149,3 +152,9 @@ Description:
>   		security.ima xattr of a file:
>   
>   			appraise func=SETXATTR_CHECK appraise_algos=sha256,sha384,sha512
> +
> +		Example of a 'measure' rule requiring fs-verity's digests
> +		with indication of type of digest in the measurement list.
> +
> +			measure func=FILE_CHECK digest_type=verity \
> +				template=ima-ngv2
> diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
> index 1a91d92950a7..2d4789dc7750 100644
> --- a/Documentation/security/IMA-templates.rst
> +++ b/Documentation/security/IMA-templates.rst
> @@ -68,6 +68,9 @@ descriptors by adding their identifier to the format string
>    - 'd-ng': the digest of the event, calculated with an arbitrary hash
>      algorithm (field format: [<hash algo>:]digest, where the digest
>      prefix is shown only if the hash algorithm is not SHA1 or MD5);
> + - 'd-ngv2': same as d-ng, but prefixed with the digest type.
> +    field format: [<digest type>:<hash algo>:]digest,
> +        where the digest type is either "ima" or "verity".
>    - 'd-modsig': the digest of the event without the appended modsig;
>    - 'n-ng': the name of the event, without size limitations;
>    - 'sig': the file signature, or the EVM portable signature if the file
> @@ -106,3 +109,8 @@ currently the following methods are supported:
>      the ``ima_template=`` parameter;
>    - register a new template descriptor with custom format through the kernel
>      command line parameter ``ima_template_fmt=``.
> +
> +
> +References
> +==========
> +[1] Documentation/filesystems/fsverity.rst
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index c6805af46211..525b13916745 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -14,6 +14,7 @@
>   #include <linux/xattr.h>
>   #include <linux/evm.h>
>   #include <linux/iversion.h>
> +#include <linux/fsverity.h>
>   
>   #include "ima.h"
>   
> @@ -200,6 +201,23 @@ int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
>   				allowed_algos);
>   }
>   
> +static int ima_get_verity_digest(struct integrity_iint_cache *iint,
> +				 struct ima_max_digest_data *hash)
> +{
> +	u8 verity_digest[FS_VERITY_MAX_DIGEST_SIZE];
> +	enum hash_algo verity_alg;
> +	int ret;
> +
> +	ret = fsverity_get_digest(iint->inode, verity_digest, &verity_alg);
> +	if (ret)
> +		return ret;
> +	if (hash->hdr.algo != verity_alg)
> +		return -EINVAL;
> +	hash->hdr.length = hash_digest_size[verity_alg];
> +	memcpy(hash->hdr.digest, verity_digest, hash->hdr.length);

Could you not pass hash->hdr.digest into fsverity_get_digest() and avoid 
the copying here?

> +	return 0;
> +}
> +
>   /*
>    * ima_collect_measurement - collect file measurement
>    *
> @@ -242,14 +260,30 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>   	 */
>   	i_version = inode_query_iversion(inode);
>   	hash.hdr.algo = algo;
> +	hash.hdr.length = hash_digest_size[algo];
>   
>   	/* Initialize hash digest to 0's in case of failure */
>   	memset(&hash.digest, 0, sizeof(hash.digest));
>   
> -	if (buf)
> +	if (buf) {
>   		result = ima_calc_buffer_hash(buf, size, &hash.hdr);
> -	else
> +	} else if (iint->flags & IMA_VERITY_REQUIRED) {
> +		result = ima_get_verity_digest(iint, &hash);
> +		switch (result) {
> +		case 0:
> +			break;
> +		case -ENODATA:
> +			audit_cause = "no-verity-digest";
> +			result = -EINVAL;
> +			break;
> +		case -EINVAL:
> +		default:
> +			audit_cause = "invalid-verity-digest";
> +			break;
> +		}
> +	} else {
>   		result = ima_calc_file_hash(file, &hash.hdr);
> +	}
>   
>   	if (result && result != -EBADF && result != -EINVAL)
>   		goto out;
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index a0f3775cbd82..c6b0454b2e25 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1024,6 +1024,7 @@ enum policy_opt {
>   	Opt_fowner_gt, Opt_fgroup_gt,
>   	Opt_uid_lt, Opt_euid_lt, Opt_gid_lt, Opt_egid_lt,
>   	Opt_fowner_lt, Opt_fgroup_lt,
> +	Opt_digest_type,
>   	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
>   	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
>   	Opt_label, Opt_err
> @@ -1066,6 +1067,7 @@ static const match_table_t policy_tokens = {
>   	{Opt_egid_lt, "egid<%s"},
>   	{Opt_fowner_lt, "fowner<%s"},
>   	{Opt_fgroup_lt, "fgroup<%s"},
> +	{Opt_digest_type, "digest_type=%s"},
>   	{Opt_appraise_type, "appraise_type=%s"},
>   	{Opt_appraise_flag, "appraise_flag=%s"},
>   	{Opt_appraise_algos, "appraise_algos=%s"},
> @@ -1173,6 +1175,21 @@ static void check_template_modsig(const struct ima_template_desc *template)
>   #undef MSG
>   }
>   
> +/*
> + * Make sure the policy rule and template format are in sync.
If they are not in sync I need to update my policy rule?

> + */
> +static void check_template_field(const struct ima_template_desc *template,
> +				 const char *field, const char *msg)
> +{
> +	int i;
> +
> +	for (i = 0; i < template->num_fields; i++)
> +		if (!strcmp(template->fields[i]->field_id, field))
> +			return;
> +
> +	pr_notice_once("%s", msg)
> +}
> +
>   static bool ima_validate_rule(struct ima_rule_entry *entry)
>   {
>   	/* Ensure that the action is set and is compatible with the flags */
> @@ -1215,7 +1232,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>   				     IMA_INMASK | IMA_EUID | IMA_PCR |
>   				     IMA_FSNAME | IMA_GID | IMA_EGID |
>   				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
> -				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS))
> +				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS |
> +				     IMA_VERITY_REQUIRED))
>   			return false;
>   
>   		break;
> @@ -1708,6 +1726,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   						   LSM_SUBJ_TYPE,
>   						   AUDIT_SUBJ_TYPE);
>   			break;
> +		case Opt_digest_type:
> +			ima_log_string(ab, "digest_type", args[0].from);
> +			if ((strcmp(args[0].from, "verity")) == 0)
> +				entry->flags |= IMA_VERITY_REQUIRED;
> +			else
> +				result = -EINVAL;
> +			break;
>   		case Opt_appraise_type:
>   			ima_log_string(ab, "appraise_type", args[0].from);
>   			if ((strcmp(args[0].from, "imasig")) == 0)
> @@ -1798,6 +1823,15 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   		check_template_modsig(template_desc);
>   	}
>   
> +	/* d-ngv2 template field recommended for unsigned fs-verity digests */
> +	if (!result && entry->action == MEASURE &&
> +	    entry->flags & IMA_VERITY_REQUIRED) {
> +		template_desc = entry->template ? entry->template :
> +						  ima_template_desc_current();
> +		check_template_field(template_desc, "d-ngv2",
> +				     "verity rules should include d-ngv2");
> +	}
> +
>   	audit_log_format(ab, "res=%d", !result);
>   	audit_log_end(ab);
>   	return result;
> @@ -2155,6 +2189,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>   		else
>   			seq_puts(m, "appraise_type=imasig ");
>   	}
> +	if (entry->flags & IMA_VERITY_REQUIRED)
> +		seq_puts(m, "digest_type=verity ");
>   	if (entry->flags & IMA_CHECK_BLACKLIST)
>   		seq_puts(m, "appraise_flag=check_blacklist ");
>   	if (entry->flags & IMA_PERMIT_DIRECTIO)
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index bd95864a5f6f..0cff6658a4c2 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -31,7 +31,7 @@ enum data_formats {
>   };
>   
>   #define DIGEST_TYPE_MAXLEN 16	/* including NULL */
> -static const char * const digest_type_name[] = {"ima"};
> +static const char * const digest_type_name[] = {"ima", "verity"};
>   static int digest_type_size = ARRAY_SIZE(digest_type_name);

if this static needs to exist at all, and I dn't think it should, it 
should probably be called digest_type_array_size. Though I would just 
use ARRAY_SIZE() where needed.

>   
>   static int ima_write_template_field_data(const void *data, const u32 datalen,
> @@ -430,6 +430,8 @@ int ima_eventdigest_ngv2_init(struct ima_event_data *event_data,
>   	cur_digestsize = event_data->iint->ima_hash->length;
>   
>   	hash_algo = event_data->iint->ima_hash->algo;
> +	if (event_data->iint->flags & IMA_VERITY_REQUIRED)
> +		digest_type = 1;
>   out:
>   	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
>   					   digest_type, hash_algo, field_data);
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index daf49894fd7d..d42a01903f08 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -32,7 +32,7 @@
>   #define IMA_HASHED		0x00000200
>   
>   /* iint policy rule cache flags */
> -#define IMA_NONACTION_FLAGS	0xff000000
> +#define IMA_NONACTION_FLAGS	0xff800000
>   #define IMA_DIGSIG_REQUIRED	0x01000000
>   #define IMA_PERMIT_DIRECTIO	0x02000000
>   #define IMA_NEW_FILE		0x04000000
> @@ -40,6 +40,7 @@
>   #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
>   #define IMA_MODSIG_ALLOWED	0x20000000
>   #define IMA_CHECK_BLACKLIST	0x40000000
> +#define IMA_VERITY_REQUIRED	0x80000000
>   
>   #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
>   				 IMA_HASH | IMA_APPRAISE_SUBMASK)
