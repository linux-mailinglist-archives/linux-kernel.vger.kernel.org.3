Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF844DA717
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352861AbiCPAty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352854AbiCPAtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51CCD275E9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647391718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wgRCg5rHLO663AukahnIUlWXYq2JT3ybopJbTiJj1k=;
        b=jRMgiChy08O7GgGGRD2ZfdrVFW/SmPDp5r0z3WTpErAJ8wGdeEOLJkfGBNm0YFSHesf0oH
        54yB+FOFkUgUS37niJt4pmhcfGrwRcqrh0YWCxseZBw+Krsj7qLgyz9BwJHH1umcQrSG3+
        PXdyfc9ezhrZYqJytnAEoUcLyK59u4I=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-D62ycw0pPy6CDoWtg1gHrA-1; Tue, 15 Mar 2022 20:48:37 -0400
X-MC-Unique: D62ycw0pPy6CDoWtg1gHrA-1
Received: by mail-pl1-f198.google.com with SMTP id w24-20020a170902a71800b001538d7b076dso343003plq.16
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3wgRCg5rHLO663AukahnIUlWXYq2JT3ybopJbTiJj1k=;
        b=BehGaEcrDYrqVme95C+DzvEbkl7cMAb1ZLdT5iq5FdJBQruMVkHiDovTMf5ytf3ASn
         RwdwU0JHWqvspeMrJnmGiP3z9hU/37/r7TLkfxMGgz5kx8MIW6xCwNk8DSBgECj8FEnh
         b+0IO65XcF0zjq8HAwnddxqmL6TpAcaIWclXLSDTnYJlBsduwSZpunCUJATmtOamDnTT
         +iHBYamNn3/0ALdpXIqVs2A0I04+woaUe1v57cI25x9DlBnIoNK9ge8Wf1HMG0qiXeb0
         SWprUXD06a3s/CsoJAVO8lTv9cxZYPgjLtbcDTolVoheOkG+ZQn+BE8OsplVUDHU4jIp
         he8Q==
X-Gm-Message-State: AOAM531lUFhwFLZO5kcadBumc2J6V6hrAbjH70lwAxB5fei4AgFewQoj
        IDobuiuKDxH/+1u3mQAf092Pu8hMU9mscmC5Psmi6E6qSR6HhdEy8BnoRM0ZCIFHU2apwXFdCdn
        3CNUh/ogM9Y9qeAPTmT1eBlSN12PtTSSeTo5kFhmcTob5zuXTrizh423gjUCvjlKxQVOxurcu0A
        ==
X-Received: by 2002:a63:2d5:0:b0:380:b650:f948 with SMTP id 204-20020a6302d5000000b00380b650f948mr26319032pgc.37.1647391716086;
        Tue, 15 Mar 2022 17:48:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/EuxJR8F+CmeO2gnkczskKa4EqhaacvFTKGED45uanz3yM1nO0Aw2PqT11iclTxWX5+psYQ==
X-Received: by 2002:a63:2d5:0:b0:380:b650:f948 with SMTP id 204-20020a6302d5000000b00380b650f948mr26319012pgc.37.1647391715786;
        Tue, 15 Mar 2022 17:48:35 -0700 (PDT)
Received: from [10.72.12.110] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d19-20020a056a00199300b004f7b7bb0733sm327732pfl.60.2022.03.15.17.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 17:48:35 -0700 (PDT)
Subject: Re: [RFC PATCH v2 3/3] ceph: update documentation regarding snapshot
 naming limitations
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220315161959.19453-1-lhenriques@suse.de>
 <20220315161959.19453-4-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <db0eb19c-7ad9-8cc1-b0da-59b59c308cc1@redhat.com>
Date:   Wed, 16 Mar 2022 08:48:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220315161959.19453-4-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/16/22 12:19 AM, Luís Henriques wrote:
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   Documentation/filesystems/ceph.rst | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/filesystems/ceph.rst b/Documentation/filesystems/ceph.rst
> index 4942e018db85..d487cabe792d 100644
> --- a/Documentation/filesystems/ceph.rst
> +++ b/Documentation/filesystems/ceph.rst
> @@ -57,6 +57,16 @@ a snapshot on any subdirectory (and its nested contents) in the
>   system.  Snapshot creation and deletion are as simple as 'mkdir
>   .snap/foo' and 'rmdir .snap/foo'.
>   
> +Snapshot names have two limitations:
> +
> +* They can not start with an underscore ('_'), as these names are reserved
> +  for internal usage by the MDS.
> +* They can not exceed 240 characters in size.  This is because the MDS makes
> +  use of long snapshot names internally, which follow the format:
> +  `_<SNAPSHOT-NAME>_<INODE-NUMBER>`.  Since filenames in general can't have
> +  more than 255 characters, and `<node-id>` takes 13 characters, the long
> +  snapshot names can take as much as 255 - 1 - 1 - 13 = 240.
> +
>   Ceph also provides some recursive accounting on directories for nested
>   files and bytes.  That is, a 'getfattr -d foo' on any directory in the
>   system will reveal the total number of nested regular files and
>
LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

