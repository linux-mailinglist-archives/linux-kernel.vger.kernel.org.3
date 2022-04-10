Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799224FB01D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243923AbiDJUe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbiDJUeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:34:25 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CE112ACD;
        Sun, 10 Apr 2022 13:32:12 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c199so7505045qkg.4;
        Sun, 10 Apr 2022 13:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=huWJqoMceKY9utLcra3c7y8vTuIRshoTFpvffz76D/g=;
        b=RDIBal9Z/TwlB7Lbv0yyxNt9bJ+KIuvgx9oUxYYPUPMq+25gHsyv++/J8VQL1KNFTT
         RDYw8m5H5HAMRmzhVb25uJBdw7vRzlGzeafKKT2fPIG1ESL6qyAkjIVCuoixP4ylEcfF
         stm6tErwFc8JVxS+Zt6wA1RfpB/w5eqalpFBjsHcZ+Hen7e62fmKUkxQMXjXsOJwtN8F
         46VgWPjUr6BkmZHLebb4QyCW7a0CxFPZMeMCVP9p4fJZvFF0tXmJzlO6oUpS6Xn15AiR
         Dh5QM+1QO9ScWU53soSFM+Sy/36c8tXYOIqoWvKtpQtf0sfXvntI5j393OSZwDgC+14U
         Q2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=huWJqoMceKY9utLcra3c7y8vTuIRshoTFpvffz76D/g=;
        b=QwS3U69oZlqjOeCGdV4LybpNusPW8ILBp+tAtdBXTw+UNrOwerS3NuYOR5QoGH3fQN
         ublz26YbUneRA6sVkQd6ie368Jb3Wyxawd/v+Td6PEkRpYwCFbC/dZf7jDaHzqtrAPPm
         sBSBc9MoncnhtOdMrBE1C/t2LOjF1L4memHAUrWSI92L641SiEu6yosBNy9Zo8vEHUW6
         qoLa5Dp5dL7ypG8n68qhgPC7M49pYWgtUrueo4vM1qdI7eOVu2LgjSe6jkkpc99ldaLb
         4cAK1GA6dXVFwMp2a/0zKaNQRZIjNteFZom2+WZlLMDyviKs2WMr2Ybi6BXl3aDkAMYv
         BhHg==
X-Gm-Message-State: AOAM532jvMDwj+QVnFbx8EnOXSUsbWhMW3zKA/7KXsoZq/a/zOj/b25q
        5FSNQpwYltBGDn4L6ad2XuU=
X-Google-Smtp-Source: ABdhPJwTIstBpo9II0fA1RQtvoW3eD0TuNtP0QU7jWHLb5hGRrF993pYod8z3vyPDL/4Y5l1iCFwhw==
X-Received: by 2002:a37:bce:0:b0:69b:f818:3389 with SMTP id 197-20020a370bce000000b0069bf8183389mr5298326qkl.330.1649622731468;
        Sun, 10 Apr 2022 13:32:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:6c1b:d125:bcaa:58ab? ([2600:1700:2442:6db0:6c1b:d125:bcaa:58ab])
        by smtp.gmail.com with ESMTPSA id i2-20020a05620a248200b00680f3c2f888sm20904993qkn.126.2022.04.10.13.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 13:32:11 -0700 (PDT)
Message-ID: <bddcda82-709a-e91f-ffb4-67af6cad7aa0@gmail.com>
Date:   Sun, 10 Apr 2022 15:32:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] of: overlay: of_overlay_apply() kfree() errors
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Slawomir Stepien <sst@poczta.fm>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
References: <20220408172103.371637-1-frowand.list@gmail.com>
 <CAL_JsqJC6pKxEmwMeirVLwJEbOH0WD+01VEfFXC257a+ZDRtsw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqJC6pKxEmwMeirVLwJEbOH0WD+01VEfFXC257a+ZDRtsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 12:34, Rob Herring wrote:
> On Fri, Apr 8, 2022 at 12:21 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
> 
> The subject needs a verb.
> 
>>
>> Fix various kfree() issues related to of_overlay_apply().
>>   - Double kfree() of fdt and tree when init_overlay_changeset()
>>     returns an error.
>>   - free_overlay_changeset() free of the root of the unflattened
>>     overlay (variable tree) instead of the memory that contains
>>     the unflattened overlay.
>>   - Move similar kfree()s from multiple error locations to a
>>     common error path (err_free_tree_unlocked:).
> 
> What about my question/suggestion on the original patch from Slawomir?

Thanks for pointing those out.  I have now replied in that email thread
and v2 of my patch will be much better due to your comments there.

-Frank

> 
>>
>> Double kfree()
>> Reported-by: Slawomir Stepien <slawomir.stepien@nokia.com>
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/overlay.c | 64 ++++++++++++++++++++++++++++----------------
>>  1 file changed, 41 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index d80160cf34bb..1b9a90d61496 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -58,6 +58,7 @@ struct fragment {
>>   * @id:                        changeset identifier
>>   * @ovcs_list:         list on which we are located
>>   * @fdt:               base of memory allocated to hold aligned FDT that was unflattened to create @overlay_tree
>> + * @overlay_mem:       the memory chunk that contains @overlay_tree
>>   * @overlay_tree:      expanded device tree that contains the fragment nodes
>>   * @count:             count of fragment structures
>>   * @fragments:         fragment nodes in the overlay expanded device tree
>> @@ -68,6 +69,7 @@ struct overlay_changeset {
>>         int id;
>>         struct list_head ovcs_list;
>>         const void *fdt;
>> +       const void *overlay_mem;
>>         struct device_node *overlay_tree;
>>         int count;
>>         struct fragment *fragments;
>> @@ -720,6 +722,7 @@ static struct device_node *find_target(struct device_node *info_node)
>>   * init_overlay_changeset() - initialize overlay changeset from overlay tree
>>   * @ovcs:      Overlay changeset to build
>>   * @fdt:       base of memory allocated to hold aligned FDT that was unflattened to create @tree
>> + * @tree_mem:  Memory that contains @tree
>>   * @tree:      Contains the overlay fragments and overlay fixup nodes
>>   *
>>   * Initialize @ovcs.  Populate @ovcs->fragments with node information from
>> @@ -730,13 +733,23 @@ static struct device_node *find_target(struct device_node *info_node)
>>   * detected in @tree, or -ENOSPC if idr_alloc() error.
>>   */
>>  static int init_overlay_changeset(struct overlay_changeset *ovcs,
>> -               const void *fdt, struct device_node *tree)
>> +               const void *fdt, const void *tree_mem, struct device_node *tree)
>>  {
>>         struct device_node *node, *overlay_node;
>>         struct fragment *fragment;
>>         struct fragment *fragments;
>>         int cnt, id, ret;
>>
>> +       /*
>> +        * Must set these fields before any error return. fdt and tree_mem
>> +        * will be freed by free_overlay_changeset(), which is called if
>> +        * init_overlay_changeset() returns an error.
>> +        */
>> +
>> +       ovcs->fdt = fdt;
>> +       ovcs->overlay_mem = tree_mem;
>> +       ovcs->overlay_tree = tree;
>> +
>>         /*
>>          * Warn for some issues.  Can not return -EINVAL for these until
>>          * of_unittest_apply_overlay() is fixed to pass these checks.
>> @@ -750,9 +763,6 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>>         if (!of_node_is_root(tree))
>>                 pr_debug("%s() tree is not root\n", __func__);
>>
>> -       ovcs->overlay_tree = tree;
>> -       ovcs->fdt = fdt;
>> -
>>         INIT_LIST_HEAD(&ovcs->ovcs_list);
>>
>>         of_changeset_init(&ovcs->cset);
>> @@ -865,7 +875,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>          * ovcs->fdt due to the policy that overlay notifiers are not allowed
>>          * to retain pointers into the overlay devicetree.
>>          */
>> -       kfree(ovcs->overlay_tree);
>> +       kfree(ovcs->overlay_mem);
>>         kfree(ovcs->fdt);
>>         kfree(ovcs);
>>  }
>> @@ -875,6 +885,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>   *
>>   * of_overlay_apply() - Create and apply an overlay changeset
>>   * @fdt:       base of memory allocated to hold the aligned FDT
>> + * @tree_mem:  Memory that contains @tree
>>   * @tree:      Expanded overlay device tree
>>   * @ovcs_id:   Pointer to overlay changeset id
>>   *
>> @@ -913,31 +924,27 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>   * id is returned to *ovcs_id.
>>   */
>>
>> -static int of_overlay_apply(const void *fdt, struct device_node *tree,
>> -               int *ovcs_id)
>> +static int of_overlay_apply(const void *fdt, void *tree_mem,
>> +               struct device_node *tree, int *ovcs_id)
>>  {
>>         struct overlay_changeset *ovcs;
>>         int ret = 0, ret_revert, ret_tmp;
>>
>>         /*
>> -        * As of this point, fdt and tree belong to the overlay changeset.
>> +        * As of this point, fdt and tree_mem belong to the overlay changeset.
>>          * overlay changeset code is responsible for freeing them.
>>          */
>>
>>         if (devicetree_corrupt()) {
>>                 pr_err("devicetree state suspect, refuse to apply overlay\n");
>> -               kfree(fdt);
>> -               kfree(tree);
>>                 ret = -EBUSY;
>> -               goto out;
>> +               goto err_free_tree_unlocked;
>>         }
>>
>>         ovcs = kzalloc(sizeof(*ovcs), GFP_KERNEL);
>>         if (!ovcs) {
>> -               kfree(fdt);
>> -               kfree(tree);
>>                 ret = -ENOMEM;
>> -               goto out;
>> +               goto err_free_tree_unlocked;
>>         }
>>
>>         of_overlay_mutex_lock();
>> @@ -947,9 +954,14 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>>         if (ret)
>>                 goto err_free_tree;
>>
>> -       ret = init_overlay_changeset(ovcs, fdt, tree);
>> +       /*
>> +        * init_overlay_changeset() promises to add tree_mem and tree to ovcs
>> +        * even in the case of an early error return, so they can be freed by
>> +        * free_overlay_changeset().
>> +        */
>> +       ret = init_overlay_changeset(ovcs, fdt, tree_mem, tree);
>>         if (ret)
>> -               goto err_free_tree;
>> +               goto err_free_overlay_changeset;
>>
>>         /*
>>          * after overlay_notify(), ovcs->overlay_tree related pointers may have
>> @@ -999,7 +1011,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>>
>>  err_free_tree:
>>         kfree(fdt);
>> -       kfree(tree);
>> +       kfree(tree_mem);
>>
>>  err_free_overlay_changeset:
>>         free_overlay_changeset(ovcs);
>> @@ -1008,9 +1020,14 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>>         mutex_unlock(&of_mutex);
>>         of_overlay_mutex_unlock();
>>
>> -out:
>>         pr_debug("%s() err=%d\n", __func__, ret);
>>
>> +       return ret;
>> +
>> +err_free_tree_unlocked:
>> +       kfree(fdt);
>> +       kfree(tree_mem);
>> +
>>         return ret;
>>  }
>>
>> @@ -1019,6 +1036,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>>  {
>>         void *new_fdt;
>>         void *new_fdt_align;
>> +       void *overlay_mem;
>>         int ret;
>>         u32 size;
>>         struct device_node *overlay_root = NULL;
>> @@ -1046,18 +1064,17 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>>         new_fdt_align = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);
>>         memcpy(new_fdt_align, overlay_fdt, size);
>>
>> -       of_fdt_unflatten_tree(new_fdt_align, NULL, &overlay_root);
>> -       if (!overlay_root) {
>> +       overlay_mem = of_fdt_unflatten_tree(new_fdt_align, NULL, &overlay_root);
>> +       if (!overlay_mem) {
>>                 pr_err("unable to unflatten overlay_fdt\n");
>>                 ret = -EINVAL;
>>                 goto out_free_new_fdt;
>>         }
>>
>> -       ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
>> +       ret = of_overlay_apply(new_fdt, overlay_mem, overlay_root, ovcs_id);
>>         if (ret < 0) {
>>                 /*
>> -                * new_fdt and overlay_root now belong to the overlay
>> -                * changeset.
>> +                * new_fdt and overlay_mem now belong to the overlay changeset.
>>                  * overlay changeset code is responsible for freeing them.
>>                  */
>>                 goto out;
>> @@ -1067,6 +1084,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>>
>>
>>  out_free_new_fdt:
>> +       kfree(overlay_mem);
>>         kfree(new_fdt);
>>
>>  out:
>> --
>> Frank Rowand <frank.rowand@sony.com>
>>

