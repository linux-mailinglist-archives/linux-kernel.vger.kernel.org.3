Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6949149E3C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiA0Nme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiA0Nma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:42:30 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E8DC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:42:29 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id b5so2434363qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QjHSgp9NDZjwilBZjtCVf/HVJNNWGbMrAyQkrXXKVgQ=;
        b=EdVizB6Aw2GIp0A1mq1fuR0buPb+iZRus81DLE3TD5gDFftGAa65Ae8wJkdcuqxyV5
         K66LTf0B+iKC0hWKqw/kqBNyF//IfpdQpc1ZXcIMgC0SCioaHVUvNNjDjG7wYRLSkv2C
         XhjLmGbqkhsWgjyV6dzrS3bZvdGUe6eibHQ9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QjHSgp9NDZjwilBZjtCVf/HVJNNWGbMrAyQkrXXKVgQ=;
        b=GyQ8IOPVuu4scNlix23SC4Xl7vSy6Q1BjIzLHxeKM53EBp85nOM2UFxPODBTRCvml4
         fpF2F89PRuvlMSS4+WLYEIWfvZLkTsBum0C8kNK2Nm9oncmdGvDCZNxd5jLETObGK0FL
         1rYyHrUjvhVOuaIGnfsi+gHXh9e+XXGZ5JqFGjBlr/ZJsC1C9O5a+4Ge0iy5JHuSeBXj
         ExSEaAU9FIOPAVS6USWF6yYp8vgc3q9szIx5kOl3rIcLE1oknNc9f0mBP62qJLk0/rDe
         CneoXlOWEivCCzk1LsZmPMautKq+WO/7ehhKRc3Megq2FJzrjwtXpEv8PXBgmYGvGPQ3
         4iiA==
X-Gm-Message-State: AOAM53282DzlRJWT3Ozr9hR8aZDuddokElfSlGMwhNJOUaPMyBzgnRIJ
        EH0m+dS9oM8jWbqmMvwm3zN9Lg==
X-Google-Smtp-Source: ABdhPJwH97vwLNie0y5K3Plq/zqPbPWuo2qYpTAjbFiD71iBaJCDJNq2TFqhvHFhMuQoZ2HFvk+iTg==
X-Received: by 2002:ac8:704f:: with SMTP id y15mr2592444qtm.550.1643290948798;
        Thu, 27 Jan 2022 05:42:28 -0800 (PST)
Received: from [192.168.1.126] ([72.85.44.115])
        by smtp.gmail.com with ESMTPSA id u16sm1440115qko.130.2022.01.27.05.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 05:42:28 -0800 (PST)
Message-ID: <8ea4d17a-f2fd-b6a5-b988-0edbc63022f6@ieee.org>
Date:   Thu, 27 Jan 2022 08:42:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] selinux: split no transition execve check
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org
References: <20220125145931.56831-1-cgzones@googlemail.com>
 <CAHC9VhTCf4L9rif-+7gTK64JoUiDv28DFwS1vUsvzv8rG+JCuQ@mail.gmail.com>
From:   Chris PeBenito <pebenito@ieee.org>
In-Reply-To: <CAHC9VhTCf4L9rif-+7gTK64JoUiDv28DFwS1vUsvzv8rG+JCuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 17:51, Paul Moore wrote:
> On Tue, Jan 25, 2022 at 9:59 AM Christian Göttsche
> <cgzones@googlemail.com> wrote:
>>
>> In case a setuid or setgid binary is mislabeled with a generic context,
>> either via a policy mistake or a move by the distribution package,
>> executing it will be checked by the file permission execute_no_trans on
>> the generic file context (e.g. bin_t).  The setuid(2)/setgid(2) syscall
>> within will then be checked against the unchanged caller process
>> context, which might have been granted the capability permission setuid/
>> setgid to initially drop privileges.  To avoid that scenario split the
>> execute_no_trans permission in case of a setuid/setgid binary into a new
>> permission execute_sxid_no_trans.
>>
>> For backward compatibility this behavior is contained in a new policy
>> capability.
>>
>> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
>> ---
>>   security/selinux/hooks.c                   | 9 ++++++++-
>>   security/selinux/include/classmap.h        | 2 +-
>>   security/selinux/include/policycap.h       | 1 +
>>   security/selinux/include/policycap_names.h | 3 ++-
>>   security/selinux/include/security.h        | 8 ++++++++
>>   5 files changed, 20 insertions(+), 3 deletions(-)
> 
> Adding the refpolicy list to this thread as their opinion seems
> particularly relevant to this discussion.
> 
> FWIW, this looks reasonable to me but I would like to hear what others
> have to say.

I think this a band-aid to cover up the real problem, which is the mislabeled files.




>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 5b6895e4fc29..b825fee39a70 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -2348,9 +2348,16 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
>>          ad.u.file = bprm->file;
>>
>>          if (new_tsec->sid == old_tsec->sid) {
>> +               u32 perm;
>> +
>> +               if (selinux_policycap_execute_sxid_no_trans() && is_sxid(inode->i_mode))
>> +                       perm = FILE__EXECUTE_SXID_NO_TRANS;
>> +               else
>> +                       perm = FILE__EXECUTE_NO_TRANS;
>> +
>>                  rc = avc_has_perm(&selinux_state,
>>                                    old_tsec->sid, isec->sid,
>> -                                 SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
>> +                                 SECCLASS_FILE, perm, &ad);
>>                  if (rc)
>>                          return rc;
>>          } else {
>> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
>> index 35aac62a662e..53a1eeeb86fb 100644
>> --- a/security/selinux/include/classmap.h
>> +++ b/security/selinux/include/classmap.h
>> @@ -65,7 +65,7 @@ struct security_class_mapping secclass_map[] = {
>>              "quotaget", "watch", NULL } },
>>          { "file",
>>            { COMMON_FILE_PERMS,
>> -           "execute_no_trans", "entrypoint", NULL } },
>> +           "execute_no_trans", "entrypoint", "execute_sxid_no_trans", NULL } },
>>          { "dir",
>>            { COMMON_FILE_PERMS, "add_name", "remove_name",
>>              "reparent", "search", "rmdir", NULL } },
>> diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
>> index 2ec038efbb03..23929dc3e1db 100644
>> --- a/security/selinux/include/policycap.h
>> +++ b/security/selinux/include/policycap.h
>> @@ -11,6 +11,7 @@ enum {
>>          POLICYDB_CAPABILITY_CGROUPSECLABEL,
>>          POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
>>          POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
>> +       POLICYDB_CAPABILITY_EXECUTE_SXID_NO_TRANS,
>>          __POLICYDB_CAPABILITY_MAX
>>   };
>>   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>> diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
>> index b89289f092c9..4c014c2cf352 100644
>> --- a/security/selinux/include/policycap_names.h
>> +++ b/security/selinux/include/policycap_names.h
>> @@ -12,7 +12,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>>          "always_check_network",
>>          "cgroup_seclabel",
>>          "nnp_nosuid_transition",
>> -       "genfs_seclabel_symlinks"
>> +       "genfs_seclabel_symlinks",
>> +       "execute_sxid_no_trans",
>>   };
>>
>>   #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
>> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
>> index ac0ece01305a..ab95241b6b7b 100644
>> --- a/security/selinux/include/security.h
>> +++ b/security/selinux/include/security.h
>> @@ -219,6 +219,14 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
>>          return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS]);
>>   }
>>
>> +static inline bool selinux_policycap_execute_sxid_no_trans(void)
>> +{
>> +       struct selinux_state *state = &selinux_state;
>> +
>> +       return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_EXECUTE_SXID_NO_TRANS]);
>> +}
>> +
>> +
>>   struct selinux_policy_convert_data;
>>
>>   struct selinux_load_state {
>> --
>> 2.34.1
>>
> 
> 


-- 
Chris PeBenito
