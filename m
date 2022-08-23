Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C693B59DD6F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355941AbiHWMLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 08:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359736AbiHWMLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E467985B8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661247457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QkzKQGB2znNxgGYTqQF+Fbl0fWwxrBy8JEIhMBuRkok=;
        b=EuA4CO2BvCVhGjVRkbj81ErUG80QqoLkIFSSsbvNBSGBkXWZkYwlu7vVFHdRJz5QsNXxlM
        LPljV6Pg9Q2UmUe4/riWbgvVI4YFRB6qqcDEwv+35JPI3evpSvqd2wy8Ki9eCWrOlgOOZs
        SMAAUKo9m2vW+FtGAWj7BGZLc2Qyxvc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-167-33g03oE6PtWBFUM4j63tzA-1; Tue, 23 Aug 2022 05:37:36 -0400
X-MC-Unique: 33g03oE6PtWBFUM4j63tzA-1
Received: by mail-qv1-f69.google.com with SMTP id gh7-20020a05621429c700b00496b1a465b1so7043510qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QkzKQGB2znNxgGYTqQF+Fbl0fWwxrBy8JEIhMBuRkok=;
        b=gV3P4/cjBXjVxXWaZRvZ1olD+LLnZooEkCaeFE0cOLbqCKR+FBYsFyJvGMQIo49Al3
         jqMORDdlZXc+rLQpfcPD+AtVsIHYH8l544xSxBXXgE4WaMk76UY8EK4G6pklKVLxRR92
         Alfxxf3OkSs/PuuxsMNajTmHlQGXrDhbu0AGubMtv8o5Sl5EqrSpw25ZEnW3P259G+DV
         yr2TRnroaHvWLoE3oxebqy88IW79w16hewhUk1atFMVNnWzeTRClBzxpmOg/Q46Dd8rl
         oYigWBUfkUtL8g2c8WJd7ns9wIqb9a2F2cHuAGlWKgdCC3EZUCrHYvpbZwILA5J/Jz7C
         uu/Q==
X-Gm-Message-State: ACgBeo0UbpGPTAvqq71/cs4gBAodr5yHgzRkFe6ILVJ+2CIkokMQz3gV
        It/6G0LrQ8vRcS9oA2cVajg6bkkXYGabO3JYwUNr6YTa6WSABGCRJjEr03VexXV0odD6yc6qX+u
        nxZHOtpRiAqwyYTP51jka642s
X-Received: by 2002:a05:6214:1941:b0:496:ca94:98aa with SMTP id q1-20020a056214194100b00496ca9498aamr13712016qvk.8.1661247456202;
        Tue, 23 Aug 2022 02:37:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6f95tC2jjoNeeCmUJtYCzXzWGMBXa5cNQ9waXKllvos0EixLez1jcWkYQvBoZtQxwzdqZv4A==
X-Received: by 2002:a05:6214:1941:b0:496:ca94:98aa with SMTP id q1-20020a056214194100b00496ca9498aamr13712009qvk.8.1661247456003;
        Tue, 23 Aug 2022 02:37:36 -0700 (PDT)
Received: from [192.168.1.165] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id v5-20020a05620a440500b006bb5cdd4031sm8501690qkp.40.2022.08.23.02.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 02:37:35 -0700 (PDT)
Message-ID: <bd7275c6-4ebe-de99-75c2-400cfa2e5026@redhat.com>
Date:   Tue, 23 Aug 2022 10:37:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Cluster-devel] [PATCH] gfs2: move from strlcpy with unused
 retval to strscpy
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
References: <20220818210144.7915-1-wsa+renesas@sang-engineering.com>
From:   Andrew Price <anprice@redhat.com>
In-Reply-To: <20220818210144.7915-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 22:01, Wolfram Sang wrote:
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
> 
> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   fs/gfs2/ops_fstype.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 549879929c84..b57d9bf4b123 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -381,8 +381,8 @@ static int init_names(struct gfs2_sbd *sdp, int silent)
>   	if (!table[0])
>   		table = sdp->sd_vfs->s_id;
>   
> -	strlcpy(sdp->sd_proto_name, proto, GFS2_FSNAME_LEN);
> -	strlcpy(sdp->sd_table_name, table, GFS2_FSNAME_LEN);
> +	strscpy(sdp->sd_proto_name, proto, GFS2_FSNAME_LEN);
> +	strscpy(sdp->sd_table_name, table, GFS2_FSNAME_LEN);

Perhaps the size should be changed to GFS2_LOCKNAME_LEN to match the 
size of the destination, too.

With that addition, this patch fixes this syzkaller report:

https://listman.redhat.com/archives/cluster-devel/2022-August/022755.html

Andy

>   
>   	table = sdp->sd_table_name;
>   	while ((table = strchr(table, '/')))
> @@ -1439,13 +1439,13 @@ static int gfs2_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   
>   	switch (o) {
>   	case Opt_lockproto:
> -		strlcpy(args->ar_lockproto, param->string, GFS2_LOCKNAME_LEN);
> +		strscpy(args->ar_lockproto, param->string, GFS2_LOCKNAME_LEN);
>   		break;
>   	case Opt_locktable:
> -		strlcpy(args->ar_locktable, param->string, GFS2_LOCKNAME_LEN);
> +		strscpy(args->ar_locktable, param->string, GFS2_LOCKNAME_LEN);
>   		break;
>   	case Opt_hostdata:
> -		strlcpy(args->ar_hostdata, param->string, GFS2_LOCKNAME_LEN);
> +		strscpy(args->ar_hostdata, param->string, GFS2_LOCKNAME_LEN);
>   		break;
>   	case Opt_spectator:
>   		args->ar_spectator = 1;

