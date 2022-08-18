Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879285983F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245004AbiHRNTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244998AbiHRNTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACEA979F5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6370C615D4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFADC433C1;
        Thu, 18 Aug 2022 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660828774;
        bh=ahSXjudbifFbRFNfNsLeVJJHunzVQQq/qhvn+lEgc8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJvs78PQmpoj0va8eo3EUBXSXJqsiPnyGGYIHHqhfMRAbZtuHhI/KTARrNhz9KXJ4
         jhRY3wwWv665QppnPKBcKsiilrVgEvRN0+wPw91h7XYtYyM2T0WMjlpJhlNtgbt6rX
         Eq+KJDk9rQ3RE9810sqyHlls4Gs8oeKQlSaz36tDBR0Uas70Zb2i4u7cbj1/lCxBt6
         P4fAYg74pY2zSulyCXWb6lEWBnX4LbV64oO6sE0hI8ck1EPTsU23vE4UxNwSS1Ez2t
         r6NUZK9hRobDgiAYMNKTti2O9O98vGLeEF3e60xfj6Yd0RLRIsVXZ8q+p+QvrbKqdj
         u32jWvfzXXwGw==
Date:   Thu, 18 Aug 2022 15:19:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, mkoutny@suse.com,
        tj@kernel.org, gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        kernel@openvz.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        shakeelb@google.com, songmuchun@bytedance.com,
        viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH] simple_xattr: switch from list to rb_tree
Message-ID: <20220818131928.6zymceds5ka7hg4u@wittgenstein>
References: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
 <d73bd478-e373-f759-2acb-2777f6bba06f@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d73bd478-e373-f759-2acb-2777f6bba06f@openvz.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 12:12:30PM +0300, Vasily Averin wrote:
> The patch was announced here:
> https://lore.kernel.org/all/62188f37-f816-08e9-cdd5-8df23131746d@openvz.org/
> "5) simple_xattrs: replace list to rb-tree
>   This significantly reduces the search time for existing entries."
> 
> It was compiled but was not tested yet.
> ---
> Currently simple_xattr uses a list to store existing entries.
> If the list grows, the presence check may be slow and potentially
> lead to problems. Red-black tree should work more efficiently
> in this situation.
> 
> This patch replaces list to rb_tree and switches simple_xattr_* calls
> to its using.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---

I think the background for the performance issues in the commit message
would be helpful and I have a few comments. Also, trying to test whether the
lockups are gone due to the rbtree switch would be +1. 

This will likely conflict with some acl/xattr changes I have lined up so
if we decide to proceed I wouldn't mind dealing with this series if
there are no objections.

>  fs/xattr.c            | 109 ++++++++++++++++++++++++++++++++----------
>  include/linux/xattr.h |  13 +++--
>  2 files changed, 92 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 6401703707f2..672f2214fcfd 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1021,6 +1021,60 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
>  	return new_xattr;
>  }
>  
> +static struct simple_xattr *simple_xattr_rb_search(struct rb_root *root,
> +						   const char* name)
> +{
> +	struct rb_node **new = &(root->rb_node), *parent = NULL;

I'd suggest to not name this "new" but rather just "cur" or "node".

> +
> +	/* Figure out where to put new node */
> +	while (*new)
> +	{

nit: that "{" should be on the same line as the while

> +		struct simple_xattr *xattr;
> +		int result;
> +
> +		xattr = container_of(*new, struct simple_xattr, node);
> +		result = strcmp(xattr->name, name);
> +
> +		parent = *new;

That variable and assignment seems unnecessary?

> +		if (result < 0)
> +			new = &((*new)->rb_left);
> +		else if (result > 0)
> +			new = &((*new)->rb_right);
> +		else
> +			return xattr;
> +	}
> +	return NULL;
> +}
> +
> +static bool simple_xattr_rb_insert(struct rb_root *root,
> +				   struct simple_xattr *new_xattr)
> +{
> +	struct rb_node **new = &(root->rb_node), *parent = NULL;
> +
> +	/* Figure out where to put new node */
> +	while (*new) {
> +		struct simple_xattr *xattr;
> +		int result;
> +
> +		xattr = container_of(*new, struct simple_xattr, node);
> +		result = strcmp(xattr->name, new_xattr->name);
> +
> +		parent = *new;
> +		if (result < 0)
> +			new = &((*new)->rb_left);
> +		else if (result > 0)
> +			new = &((*new)->rb_right);
> +		else
> +			return false;
> +	}
> +
> +	/* Add new node and rebalance tree. */
> +	rb_link_node(&new_xattr->node, parent, new);
> +	rb_insert_color(&new_xattr->node, root);
> +
> +	return true;
> +}
> +
>  /*
>   * xattr GET operation for in-memory/pseudo filesystems
>   */
> @@ -1031,10 +1085,8 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>  	int ret = -ENODATA;
>  
>  	spin_lock(&xattrs->lock);
> -	list_for_each_entry(xattr, &xattrs->head, list) {
> -		if (strcmp(name, xattr->name))
> -			continue;
> -
> +	xattr = simple_xattr_rb_search(&xattrs->rb_root, name);
> +	if (xattr) {
>  		ret = xattr->size;
>  		if (buffer) {
>  			if (size < xattr->size)
> @@ -1042,7 +1094,6 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>  			else
>  				memcpy(buffer, xattr->value, xattr->size);
>  		}
> -		break;
>  	}
>  	spin_unlock(&xattrs->lock);
>  	return ret;
> @@ -1067,7 +1118,7 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>  		     const void *value, size_t size, int flags,
>  		     ssize_t *removed_size)
>  {
> -	struct simple_xattr *xattr;
> +	struct simple_xattr *xattr = NULL;
>  	struct simple_xattr *new_xattr = NULL;
>  	int err = 0;
>  
> @@ -1088,31 +1139,36 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>  	}
>  
>  	spin_lock(&xattrs->lock);
> -	list_for_each_entry(xattr, &xattrs->head, list) {
> -		if (!strcmp(name, xattr->name)) {
> -			if (flags & XATTR_CREATE) {
> -				xattr = new_xattr;
> -				err = -EEXIST;
> -			} else if (new_xattr) {
> -				list_replace(&xattr->list, &new_xattr->list);
> +	if ((flags & XATTR_CREATE) && new_xattr) {
> +		/* create new */
> +		if (!simple_xattr_rb_insert(&xattrs->rb_root, new_xattr)) {
> +			/* already exist */
> +			xattr = new_xattr;
> +			err = -EEXIST;
> +		}
> +	} else {
> +		/* replace or remove */
> +		xattr = simple_xattr_rb_search(&xattrs->rb_root, name);
> +		if (xattr) {
> +			/* found */
> +			if (!new_xattr) {
> +				/* remove existing */
> +				rb_erase(&xattr->node, &xattrs->rb_root);
>  				if (removed_size)
>  					*removed_size = xattr->size;
>  			} else {
> -				list_del(&xattr->list);
> +				/* replace existing */
> +				rb_replace_node(&xattr->node, &new_xattr->node,
> +						&xattrs->rb_root);
>  				if (removed_size)
>  					*removed_size = xattr->size;
>  			}
> -			goto out;
> +		} else if (new_xattr) {
> +			/* not found, incorrect replace */
> +			xattr = new_xattr;
> +			err = -ENODATA;
>  		}
>  	}
> -	if (flags & XATTR_REPLACE) {

I think keeping this rather close to the original code might be nicer.
I find the code more difficult to follow afterwards. So how about
(COMPLETELY UNTESTED) sm like:

@@ -1077,30 +1139,40 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
        }

        spin_lock(&xattrs->lock);
-       list_for_each_entry(xattr, &xattrs->head, list) {
-               if (!strcmp(name, xattr->name)) {
-                       if (flags & XATTR_CREATE) {
-                               xattr = new_xattr;
-                               err = -EEXIST;
-                       } else if (new_xattr) {
-                               list_replace(&xattr->list, &new_xattr->list);
-                               if (removed_size)
-                                       *removed_size = xattr->size;
-                       } else {
-                               list_del(&xattr->list);
-                               if (removed_size)
-                                       *removed_size = xattr->size;
-                       }
-                       goto out;
+       /* Find any matching xattr by name. */
+       xattr = simple_xattr_rb_search(&xattrs->rb_root, name);
+       if (xattr) {
+               if (flags & XATTR_CREATE) {
+                       /* Creating request but the xattr already existed. */
+                       xattr = new_xattr;
+                       err = -EEXIST;
+               } else if (new_xattr) {
+                       /* Replace the existing xattr. */
+                       rb_replace_node(&xattr->node, &new_xattr->node,
+                                       &xattrs->rb_root);
+                       if (removed_size)
+                               *removed_size = xattr->size;
+               } else {
+                       /* No new xattr specified so wipe the existing xattr. */
+                       rb_erase(&xattr->node, &xattrs->rb_root);
+                       if (removed_size)
+                               *removed_size = xattr->size;
                }
+               goto out;
        }
+
        if (flags & XATTR_REPLACE) {
+               /* There's no matching xattr so fail on replace. */
                xattr = new_xattr;
                err = -ENODATA;
        } else {
-               list_add(&new_xattr->list, &xattrs->head);
-               xattr = NULL;
+               /*
+                * We're holding the lock and verified that there's no
+                * pre-existing xattr so this should always succeed.
+                */
+               WARN_ON(!simple_xattr_rb_insert(&xattrs->rb_root, new_xattr))
        }
+
 out:
        spin_unlock(&xattrs->lock);
        if (xattr) {


> -		xattr = new_xattr;
> -		err = -ENODATA;
> -	} else {
> -		list_add(&new_xattr->list, &xattrs->head);
> -		xattr = NULL;
> -	}
> -out:
>  	spin_unlock(&xattrs->lock);
>  	if (xattr) {
>  		kfree(xattr->name);
> @@ -1149,6 +1205,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  {
>  	bool trusted = capable(CAP_SYS_ADMIN);
>  	struct simple_xattr *xattr;
> +	struct rb_node *node;
>  	ssize_t remaining_size = size;
>  	int err = 0;
>  
> @@ -1170,7 +1227,9 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  #endif
>  
>  	spin_lock(&xattrs->lock);
> -	list_for_each_entry(xattr, &xattrs->head, list) {
> +	for (node = rb_first(&xattrs->rb_root); node; node = rb_next(node)) {
> +		xattr = container_of(node, struct simple_xattr, node);
> +
>  		/* skip "trusted." attributes for unprivileged callers */
>  		if (!trusted && xattr_is_trusted(xattr->name))
>  			continue;
> @@ -1191,6 +1250,6 @@ void simple_xattr_list_add(struct simple_xattrs *xattrs,
>  			   struct simple_xattr *new_xattr)
>  {
>  	spin_lock(&xattrs->lock);
> -	list_add(&new_xattr->list, &xattrs->head);
> +	simple_xattr_rb_insert(&xattrs->rb_root, new_xattr);
>  	spin_unlock(&xattrs->lock);
>  }
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 979a9d3e5bfb..bbe81cfb7a4d 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -80,12 +80,12 @@ static inline const char *xattr_prefix(const struct xattr_handler *handler)
>  }
>  
>  struct simple_xattrs {
> -	struct list_head head;
> +	struct rb_root rb_root;
>  	spinlock_t lock;
>  };
>  
>  struct simple_xattr {
> -	struct list_head list;
> +	struct rb_node node;
>  	char *name;
>  	size_t size;
>  	char value[];
> @@ -96,7 +96,7 @@ struct simple_xattr {
>   */
>  static inline void simple_xattrs_init(struct simple_xattrs *xattrs)
>  {
> -	INIT_LIST_HEAD(&xattrs->head);
> +	xattrs->rb_root = RB_ROOT;
>  	spin_lock_init(&xattrs->lock);
>  }
>  
> @@ -105,9 +105,12 @@ static inline void simple_xattrs_init(struct simple_xattrs *xattrs)
>   */
>  static inline void simple_xattrs_free(struct simple_xattrs *xattrs)
>  {
> -	struct simple_xattr *xattr, *node;
> +	struct simple_xattr *xattr;
> +	struct rb_node *node;
>  
> -	list_for_each_entry_safe(xattr, node, &xattrs->head, list) {
> +	while ((node = rb_first(&xattrs->rb_root))) {
> +		rb_erase(node, &xattrs->rb_root);
> +		xattr = container_of(node, struct simple_xattr, node);
>  		kfree(xattr->name);
>  		kvfree(xattr);
>  	}
> -- 
> 2.34.1
> 
> 
